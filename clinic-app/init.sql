PGDMP  .    ,                }            clinic    16.0    16.0 5    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    18382    clinic    DATABASE     z   CREATE DATABASE clinic WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE clinic;
                postgres    false            ,           0    0    DATABASE clinic    COMMENT     6   COMMENT ON DATABASE clinic IS 'DB clinic for DevOps';
                   postgres    false    4907            �            1259    18403    appointments    TABLE     J  CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    patient_id integer NOT NULL,
    doctor_id integer NOT NULL,
    appointment_date timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'Запланированно'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT appointments_status_check CHECK (((status)::text = ANY ((ARRAY['Запланированно'::character varying, 'Завершенно'::character varying, 'Отмененно'::character varying])::text[])))
);
     DROP TABLE public.appointments;
       public         heap    postgres    false            �            1259    18402    appointments_appointment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.appointments_appointment_id_seq;
       public          postgres    false    220            -           0    0    appointments_appointment_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;
          public          postgres    false    219            �            1259    18395    doctors    TABLE     U  CREATE TABLE public.doctors (
    doctor_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    specialty character varying(100) NOT NULL,
    phone character varying(20),
    email character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.doctors;
       public         heap    postgres    false            �            1259    18394    doctors_doctor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.doctors_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.doctors_doctor_id_seq;
       public          postgres    false    218            .           0    0    doctors_doctor_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.doctors_doctor_id_seq OWNED BY public.doctors.doctor_id;
          public          postgres    false    217            �            1259    18438    patientappointments    TABLE     h  CREATE TABLE public.patientappointments (
    record_id integer NOT NULL,
    patient_id integer NOT NULL,
    doctor_id integer NOT NULL,
    appointment_id integer NOT NULL,
    booking_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'Забронированно'::character varying,
    CONSTRAINT patientappointments_status_check CHECK (((status)::text = ANY ((ARRAY['Забронированно'::character varying, 'Посещенно'::character varying, 'Пропущенно'::character varying, 'Отмененно'::character varying])::text[])))
);
 '   DROP TABLE public.patientappointments;
       public         heap    postgres    false            �            1259    18437 !   patientappointments_record_id_seq    SEQUENCE     �   CREATE SEQUENCE public.patientappointments_record_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.patientappointments_record_id_seq;
       public          postgres    false    224            /           0    0 !   patientappointments_record_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.patientappointments_record_id_seq OWNED BY public.patientappointments.record_id;
          public          postgres    false    223            �            1259    18384    patients    TABLE       CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    date_of_birth date NOT NULL,
    gender character varying(10) NOT NULL,
    phone character varying(20),
    email character varying(100),
    address text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT patients_gender_check CHECK (((gender)::text = ANY ((ARRAY['М'::character varying, 'Ж'::character varying])::text[])))
);
    DROP TABLE public.patients;
       public         heap    postgres    false            �            1259    18383    patients_patient_id_seq    SEQUENCE     �   CREATE SEQUENCE public.patients_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.patients_patient_id_seq;
       public          postgres    false    216            0           0    0    patients_patient_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.patients_patient_id_seq OWNED BY public.patients.patient_id;
          public          postgres    false    215            �            1259    18423    registration    TABLE     �   CREATE TABLE public.registration (
    registration_id integer NOT NULL,
    patient_id integer NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    notes text
);
     DROP TABLE public.registration;
       public         heap    postgres    false            �            1259    18422     registration_registration_id_seq    SEQUENCE     �   CREATE SEQUENCE public.registration_registration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.registration_registration_id_seq;
       public          postgres    false    222            1           0    0     registration_registration_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.registration_registration_id_seq OWNED BY public.registration.registration_id;
          public          postgres    false    221            �            1259    18463    test    TABLE     j   CREATE TABLE public.test (
    test_id integer NOT NULL,
    first_name character varying(50) NOT NULL
);
    DROP TABLE public.test;
       public         heap    postgres    false            �            1259    18462    test_test_id_seq    SEQUENCE     �   CREATE SEQUENCE public.test_test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.test_test_id_seq;
       public          postgres    false    226            2           0    0    test_test_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.test_test_id_seq OWNED BY public.test.test_id;
          public          postgres    false    225            m           2604    18406    appointments appointment_id    DEFAULT     �   ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);
 J   ALTER TABLE public.appointments ALTER COLUMN appointment_id DROP DEFAULT;
       public          postgres    false    219    220    220            k           2604    18398    doctors doctor_id    DEFAULT     v   ALTER TABLE ONLY public.doctors ALTER COLUMN doctor_id SET DEFAULT nextval('public.doctors_doctor_id_seq'::regclass);
 @   ALTER TABLE public.doctors ALTER COLUMN doctor_id DROP DEFAULT;
       public          postgres    false    218    217    218            r           2604    18441    patientappointments record_id    DEFAULT     �   ALTER TABLE ONLY public.patientappointments ALTER COLUMN record_id SET DEFAULT nextval('public.patientappointments_record_id_seq'::regclass);
 L   ALTER TABLE public.patientappointments ALTER COLUMN record_id DROP DEFAULT;
       public          postgres    false    224    223    224            i           2604    18387    patients patient_id    DEFAULT     z   ALTER TABLE ONLY public.patients ALTER COLUMN patient_id SET DEFAULT nextval('public.patients_patient_id_seq'::regclass);
 B   ALTER TABLE public.patients ALTER COLUMN patient_id DROP DEFAULT;
       public          postgres    false    215    216    216            p           2604    18426    registration registration_id    DEFAULT     �   ALTER TABLE ONLY public.registration ALTER COLUMN registration_id SET DEFAULT nextval('public.registration_registration_id_seq'::regclass);
 K   ALTER TABLE public.registration ALTER COLUMN registration_id DROP DEFAULT;
       public          postgres    false    221    222    222            u           2604    18466    test test_id    DEFAULT     l   ALTER TABLE ONLY public.test ALTER COLUMN test_id SET DEFAULT nextval('public.test_test_id_seq'::regclass);
 ;   ALTER TABLE public.test ALTER COLUMN test_id DROP DEFAULT;
       public          postgres    false    226    225    226                      0    18403    appointments 
   TABLE DATA           s   COPY public.appointments (appointment_id, patient_id, doctor_id, appointment_date, status, created_at) FROM stdin;
    public          postgres    false    220   �E                 0    18395    doctors 
   TABLE DATA           h   COPY public.doctors (doctor_id, first_name, last_name, specialty, phone, email, created_at) FROM stdin;
    public          postgres    false    218   %F       #          0    18438    patientappointments 
   TABLE DATA           u   COPY public.patientappointments (record_id, patient_id, doctor_id, appointment_id, booking_date, status) FROM stdin;
    public          postgres    false    224   G                 0    18384    patients 
   TABLE DATA              COPY public.patients (patient_id, first_name, last_name, date_of_birth, gender, phone, email, address, created_at) FROM stdin;
    public          postgres    false    216   lG       !          0    18423    registration 
   TABLE DATA           ]   COPY public.registration (registration_id, patient_id, registration_date, notes) FROM stdin;
    public          postgres    false    222   �H       %          0    18463    test 
   TABLE DATA           3   COPY public.test (test_id, first_name) FROM stdin;
    public          postgres    false    226   �I       3           0    0    appointments_appointment_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 4, true);
          public          postgres    false    219            4           0    0    doctors_doctor_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.doctors_doctor_id_seq', 3, true);
          public          postgres    false    217            5           0    0 !   patientappointments_record_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.patientappointments_record_id_seq', 4, true);
          public          postgres    false    223            6           0    0    patients_patient_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.patients_patient_id_seq', 4, true);
          public          postgres    false    215            7           0    0     registration_registration_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.registration_registration_id_seq', 4, true);
          public          postgres    false    221            8           0    0    test_test_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.test_test_id_seq', 1, false);
          public          postgres    false    225            ~           2606    18411    appointments appointments_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);
 H   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_pkey;
       public            postgres    false    220            |           2606    18401    doctors doctors_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctors_pkey PRIMARY KEY (doctor_id);
 >   ALTER TABLE ONLY public.doctors DROP CONSTRAINT doctors_pkey;
       public            postgres    false    218            �           2606    18446 ,   patientappointments patientappointments_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.patientappointments
    ADD CONSTRAINT patientappointments_pkey PRIMARY KEY (record_id);
 V   ALTER TABLE ONLY public.patientappointments DROP CONSTRAINT patientappointments_pkey;
       public            postgres    false    224            z           2606    18393    patients patients_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);
 @   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_pkey;
       public            postgres    false    216            �           2606    18431    registration registration_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.registration
    ADD CONSTRAINT registration_pkey PRIMARY KEY (registration_id);
 H   ALTER TABLE ONLY public.registration DROP CONSTRAINT registration_pkey;
       public            postgres    false    222            �           2606    18468    test test_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (test_id);
 8   ALTER TABLE ONLY public.test DROP CONSTRAINT test_pkey;
       public            postgres    false    226            �           2606    18417 (   appointments appointments_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(doctor_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_doctor_id_fkey;
       public          postgres    false    4732    218    220            �           2606    18412 )   appointments appointments_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_patient_id_fkey;
       public          postgres    false    216    4730    220            �           2606    18457 ;   patientappointments patientappointments_appointment_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patientappointments
    ADD CONSTRAINT patientappointments_appointment_id_fkey FOREIGN KEY (appointment_id) REFERENCES public.appointments(appointment_id) ON DELETE CASCADE;
 e   ALTER TABLE ONLY public.patientappointments DROP CONSTRAINT patientappointments_appointment_id_fkey;
       public          postgres    false    220    224    4734            �           2606    18452 6   patientappointments patientappointments_doctor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patientappointments
    ADD CONSTRAINT patientappointments_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.doctors(doctor_id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.patientappointments DROP CONSTRAINT patientappointments_doctor_id_fkey;
       public          postgres    false    4732    218    224            �           2606    18447 7   patientappointments patientappointments_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patientappointments
    ADD CONSTRAINT patientappointments_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id) ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.patientappointments DROP CONSTRAINT patientappointments_patient_id_fkey;
       public          postgres    false    216    4730    224            �           2606    18432 )   registration registration_patient_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.registration
    ADD CONSTRAINT registration_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.registration DROP CONSTRAINT registration_patient_id_fkey;
       public          postgres    false    4730    216    222               q   x����	�@��*���|��[��؅m�'A�bG~�}��!!�P�:1�Z�|���\}���}��ɫo߂F�3,n����Q
�F7� "�ي� ��F+���B'C�{m         �   x��ϽQ�z�)�bs���ʃh���(E�P�	O��®W8�F�R�S̙d�I��Q,pFJ��[1C�'p�5�W��9�ku!��JiM�;�&Q�N�d[�=HH	T��(U�Ahth�o��n��"�>���p'���[S�\��s�����ӌ�[����i�d�ǆ�#��A.�~
�~!� �ضl��_��{���6��      #   Z   x�3�4C##S]]##CS+c+=3K3��/l���bÅ}�^��7E��>.#N($S�1'��߄��z����qqq �l�         a  x�}��N�@��ӧ�]���n[���B��P��O=h��A��#�J��f��ii� ᰛ�=��o��q�?��8���m&$�N<�s!m���F'�΂�F�{XͰ��Lc�0+BNM=��}bB�)�åe
�K�VLJS8ueו���}�E3��S�
8�D��ȋH"�9�����ȯy��l�7�0j�G�*��t�m���8�����;���s��ـo���24�5P��4w\I�jL����X��[a!�
L���6��5X��-��ǰ��"ˀ#
Y�3я�9�9�L�͕ޤ����N�<�nH��Vʊ�U���p��ʶ��z�c��aگ      !   �   x�����0C���Fm�`�� 6��P����7�� p���<W�R�t��s��|=���I9����@�%xI#G�D���Gw�0�pg�#��JJ�^Vr0�&A�V;�~~wf.�$eD�k�]���A11t�F��V���O���c�\�%oV�hEr�+�nH�e���������[��l���      %      x������ � �     