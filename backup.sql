--
-- PostgreSQL database dump
--

\restrict NvhTGEFpfwAXrc4w4TSYKvxShC7msas01Y519U9sp4nFZ9MDidsUevda63qLbDb

-- Dumped from database version 17.8 (a284a84)
-- Dumped by pg_dump version 18.3 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: neondb_owner
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: neondb_owner
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: neondb_owner
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- Name: admin_credentials; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.admin_credentials (
    id integer NOT NULL,
    user_id character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.admin_credentials OWNER TO neondb_owner;

--
-- Name: admin_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.admin_credentials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_credentials_id_seq OWNER TO neondb_owner;

--
-- Name: admin_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.admin_credentials_id_seq OWNED BY public.admin_credentials.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.cart_items (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    added_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cart_items OWNER TO neondb_owner;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO neondb_owner;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    icon character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.categories OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO neondb_owner;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: discount_tiers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.discount_tiers (
    id integer NOT NULL,
    product_id integer NOT NULL,
    participant_count integer NOT NULL,
    discount_percentage numeric(5,2) NOT NULL,
    final_price numeric(10,2) NOT NULL
);


ALTER TABLE public.discount_tiers OWNER TO neondb_owner;

--
-- Name: discount_tiers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.discount_tiers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.discount_tiers_id_seq OWNER TO neondb_owner;

--
-- Name: discount_tiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.discount_tiers_id_seq OWNED BY public.discount_tiers.id;


--
-- Name: feedback_submissions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.feedback_submissions (
    id integer NOT NULL,
    user_id character varying,
    feedback_text text NOT NULL,
    image_url character varying(500),
    status character varying(20) DEFAULT 'new'::character varying,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.feedback_submissions OWNER TO neondb_owner;

--
-- Name: feedback_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.feedback_submissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_submissions_id_seq OWNER TO neondb_owner;

--
-- Name: feedback_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.feedback_submissions_id_seq OWNED BY public.feedback_submissions.id;


--
-- Name: grocery_products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.grocery_products (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_title character varying(255),
    product_description text,
    brand character varying(100),
    sku_id character varying(50),
    sku_code character varying(50),
    gtin character varying(20),
    barcode_symbology character varying(20),
    uom character varying(20),
    net_content_value numeric(10,3),
    net_content_uom character varying(20),
    is_variable_weight boolean DEFAULT false,
    plu_code character varying(20),
    dietary_tags text,
    allergens text,
    country_of_origin character varying(100),
    temperature_zone character varying(20),
    shelf_life_days integer,
    storage_instructions text,
    substitutable boolean DEFAULT true,
    gross_weight_g numeric(10,2),
    list_price_cents integer,
    sale_price_cents integer,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    tax_class character varying(50),
    inventory_on_hand integer DEFAULT 0,
    inventory_reserved integer DEFAULT 0,
    inventory_status character varying(20) DEFAULT 'in_stock'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.grocery_products OWNER TO neondb_owner;

--
-- Name: grocery_products_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.grocery_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.grocery_products_id_seq OWNER TO neondb_owner;

--
-- Name: grocery_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.grocery_products_id_seq OWNED BY public.grocery_products.id;


--
-- Name: group_payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.group_payments (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    user_group_id integer NOT NULL,
    product_id integer NOT NULL,
    stripe_payment_intent_id character varying(255),
    amount numeric(10,2) NOT NULL,
    currency character varying(10) DEFAULT 'cad'::character varying,
    status character varying(20) NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    payer_id character varying
);


ALTER TABLE public.group_payments OWNER TO neondb_owner;

--
-- Name: group_payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.group_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.group_payments_id_seq OWNER TO neondb_owner;

--
-- Name: group_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.group_payments_id_seq OWNED BY public.group_payments.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.order_items OWNER TO neondb_owner;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO neondb_owner;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    final_price numeric(10,2) NOT NULL,
    shipping_address text,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    total_price numeric(10,2) NOT NULL,
    type character varying(20) DEFAULT 'group'::character varying,
    address_id integer,
    product_id integer,
    quantity integer DEFAULT 1,
    unit_price numeric(10,2),
    payer_id character varying,
    expected_delivery_date timestamp without time zone,
    actual_delivery_date timestamp without time zone,
    delivery_method character varying(20) DEFAULT 'delivery'::character varying,
    user_group_id integer
);


ALTER TABLE public.orders OWNER TO neondb_owner;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO neondb_owner;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: pet_provider_staff; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.pet_provider_staff (
    id integer NOT NULL,
    pet_provider_id integer NOT NULL,
    name character varying(255) NOT NULL,
    skills jsonb,
    availability jsonb,
    rating numeric(2,1),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.pet_provider_staff OWNER TO neondb_owner;

--
-- Name: pet_provider_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.pet_provider_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pet_provider_staff_id_seq OWNER TO neondb_owner;

--
-- Name: pet_provider_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.pet_provider_staff_id_seq OWNED BY public.pet_provider_staff.id;


--
-- Name: pet_providers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.pet_providers (
    id integer NOT NULL,
    product_id integer NOT NULL,
    legal_name character varying(255),
    display_name character varying(255),
    service_category character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    license_number character varying(100),
    insurance_valid_till timestamp without time zone,
    years_in_business integer,
    service_mode character varying(20) DEFAULT 'in_person'::character varying,
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    locality character varying(100),
    region character varying(100),
    postal_code character varying(20),
    country character varying(100) DEFAULT 'India'::character varying,
    service_area_polygon jsonb,
    service_name character varying(255),
    duration_minutes integer,
    pricing_model character varying(50),
    materials_included boolean DEFAULT false,
    tax_class character varying(50),
    age_restriction integer,
    availability_type character varying(30),
    operating_hours jsonb,
    advance_booking_days integer DEFAULT 7,
    cancellation_policy_url character varying(500),
    reschedule_allowed boolean DEFAULT true,
    avg_rating numeric(2,1) DEFAULT '0'::numeric,
    review_count integer DEFAULT 0,
    highlighted_testimonials jsonb,
    insurance_policy_number character varying(100),
    liability_waiver_required boolean DEFAULT false,
    health_safety_cert character varying(500),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.pet_providers OWNER TO neondb_owner;

--
-- Name: pet_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.pet_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pet_providers_id_seq OWNER TO neondb_owner;

--
-- Name: pet_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.pet_providers_id_seq OWNED BY public.pet_providers.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.products (
    id integer NOT NULL,
    seller_id character varying NOT NULL,
    category_id integer,
    name character varying(255) NOT NULL,
    description text,
    image_url character varying(500),
    original_price numeric(10,2) NOT NULL,
    minimum_participants integer DEFAULT 10 NOT NULL,
    maximum_participants integer DEFAULT 1000 NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    offer_valid_till timestamp without time zone,
    subcategory_id integer
);


ALTER TABLE public.products OWNER TO neondb_owner;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO neondb_owner;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: seller_inquiries; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.seller_inquiries (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    phone_number character varying(50) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.seller_inquiries OWNER TO neondb_owner;

--
-- Name: seller_inquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.seller_inquiries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seller_inquiries_id_seq OWNER TO neondb_owner;

--
-- Name: seller_inquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.seller_inquiries_id_seq OWNED BY public.seller_inquiries.id;


--
-- Name: seller_notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.seller_notifications (
    id integer NOT NULL,
    seller_id character varying NOT NULL,
    type character varying(50) NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    data jsonb,
    is_read boolean DEFAULT false,
    priority character varying(20) DEFAULT 'normal'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    read_at timestamp without time zone
);


ALTER TABLE public.seller_notifications OWNER TO neondb_owner;

--
-- Name: seller_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.seller_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seller_notifications_id_seq OWNER TO neondb_owner;

--
-- Name: seller_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.seller_notifications_id_seq OWNED BY public.seller_notifications.id;


--
-- Name: service_provider_staff; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service_provider_staff (
    id integer NOT NULL,
    service_provider_id integer NOT NULL,
    name character varying(255) NOT NULL,
    skills jsonb,
    availability jsonb,
    rating numeric(2,1),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.service_provider_staff OWNER TO neondb_owner;

--
-- Name: service_provider_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_provider_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_provider_staff_id_seq OWNER TO neondb_owner;

--
-- Name: service_provider_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_provider_staff_id_seq OWNED BY public.service_provider_staff.id;


--
-- Name: service_providers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service_providers (
    id integer NOT NULL,
    product_id integer NOT NULL,
    legal_name character varying(255),
    display_name character varying(255),
    service_category character varying(100),
    status character varying(20) DEFAULT 'active'::character varying,
    license_number character varying(100),
    insurance_valid_till timestamp without time zone,
    years_in_business integer,
    service_mode character varying(20) DEFAULT 'in_person'::character varying,
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    locality character varying(100),
    region character varying(100),
    postal_code character varying(20),
    country character varying(100) DEFAULT 'India'::character varying,
    service_area_polygon jsonb,
    service_name character varying(255),
    duration_minutes integer,
    pricing_model character varying(50),
    materials_included boolean DEFAULT false,
    tax_class character varying(50),
    age_restriction integer,
    availability_type character varying(30),
    operating_hours jsonb,
    advance_booking_days integer DEFAULT 7,
    cancellation_policy_url character varying(500),
    reschedule_allowed boolean DEFAULT true,
    avg_rating numeric(2,1) DEFAULT '0'::numeric,
    review_count integer DEFAULT 0,
    highlighted_testimonials jsonb,
    insurance_policy_number character varying(100),
    liability_waiver_required boolean DEFAULT false,
    health_safety_cert character varying(500),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.service_providers OWNER TO neondb_owner;

--
-- Name: service_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_providers_id_seq OWNER TO neondb_owner;

--
-- Name: service_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_providers_id_seq OWNED BY public.service_providers.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess jsonb NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO neondb_owner;

--
-- Name: subcategories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.subcategories (
    id integer NOT NULL,
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.subcategories OWNER TO neondb_owner;

--
-- Name: subcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.subcategories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subcategories_id_seq OWNER TO neondb_owner;

--
-- Name: subcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.subcategories_id_seq OWNED BY public.subcategories.id;


--
-- Name: user_addresses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_addresses (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    nickname character varying(100) NOT NULL,
    full_name character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL,
    address_line text NOT NULL,
    city character varying(100) NOT NULL,
    pincode character varying(20) NOT NULL,
    state character varying(100) NOT NULL,
    country character varying(100) DEFAULT 'Canada'::character varying,
    is_default boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_addresses OWNER TO neondb_owner;

--
-- Name: user_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_addresses_id_seq OWNER TO neondb_owner;

--
-- Name: user_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_addresses_id_seq OWNED BY public.user_addresses.id;


--
-- Name: user_group_items; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_group_items (
    id integer NOT NULL,
    user_group_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    added_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_group_items OWNER TO neondb_owner;

--
-- Name: user_group_items_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_group_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_group_items_id_seq OWNER TO neondb_owner;

--
-- Name: user_group_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_group_items_id_seq OWNED BY public.user_group_items.id;


--
-- Name: user_group_participants; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_group_participants (
    id integer NOT NULL,
    user_group_id integer NOT NULL,
    user_id character varying NOT NULL,
    joined_at timestamp without time zone DEFAULT now(),
    status character varying(20) DEFAULT 'pending'::character varying
);


ALTER TABLE public.user_group_participants OWNER TO neondb_owner;

--
-- Name: user_group_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_group_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_group_participants_id_seq OWNER TO neondb_owner;

--
-- Name: user_group_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_group_participants_id_seq OWNED BY public.user_group_participants.id;


--
-- Name: user_groups; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.user_groups (
    id integer NOT NULL,
    user_id character varying NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    share_token character varying(32) NOT NULL,
    is_public boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    max_members integer DEFAULT 5 NOT NULL,
    delivery_method character varying(20) DEFAULT 'delivery'::character varying,
    pickup_address_id integer
);


ALTER TABLE public.user_groups OWNER TO neondb_owner;

--
-- Name: user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_groups_id_seq OWNER TO neondb_owner;

--
-- Name: user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.user_groups_id_seq OWNED BY public.user_groups.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id character varying DEFAULT gen_random_uuid() NOT NULL,
    email character varying,
    first_name character varying,
    last_name character varying,
    profile_image_url character varying,
    is_seller boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    phone_number character varying,
    store_id character varying(50),
    shop_type character varying(20) DEFAULT 'groceries'::character varying,
    legal_name character varying(255),
    display_name character varying(255),
    status character varying(20) DEFAULT 'active'::character varying,
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    locality character varying(100),
    region character varying(100),
    postal_code character varying(20),
    country character varying(100),
    timezone character varying(50),
    operating_hours character varying(255),
    currency character varying(10),
    languages text,
    substitution_policy character varying(50),
    age_check_enabled boolean DEFAULT false,
    refund_policy_url character varying(500),
    service_area_polygon jsonb,
    pickup_hours character varying(255),
    delivery_hours character varying(255),
    delivery_fee numeric(10,2) DEFAULT 0.00,
    free_delivery_threshold numeric(10,2) DEFAULT 0.00,
    minimum_order_value numeric(10,2) DEFAULT 0.00,
    delivery_radius_km integer DEFAULT 10,
    delivery_fee_per_km numeric(10,2) DEFAULT 5.99
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- Name: admin_credentials id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_credentials ALTER COLUMN id SET DEFAULT nextval('public.admin_credentials_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: discount_tiers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.discount_tiers ALTER COLUMN id SET DEFAULT nextval('public.discount_tiers_id_seq'::regclass);


--
-- Name: feedback_submissions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feedback_submissions ALTER COLUMN id SET DEFAULT nextval('public.feedback_submissions_id_seq'::regclass);


--
-- Name: grocery_products id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.grocery_products ALTER COLUMN id SET DEFAULT nextval('public.grocery_products_id_seq'::regclass);


--
-- Name: group_payments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments ALTER COLUMN id SET DEFAULT nextval('public.group_payments_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: pet_provider_staff id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_provider_staff ALTER COLUMN id SET DEFAULT nextval('public.pet_provider_staff_id_seq'::regclass);


--
-- Name: pet_providers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_providers ALTER COLUMN id SET DEFAULT nextval('public.pet_providers_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: seller_inquiries id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.seller_inquiries ALTER COLUMN id SET DEFAULT nextval('public.seller_inquiries_id_seq'::regclass);


--
-- Name: seller_notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.seller_notifications ALTER COLUMN id SET DEFAULT nextval('public.seller_notifications_id_seq'::regclass);


--
-- Name: service_provider_staff id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_provider_staff ALTER COLUMN id SET DEFAULT nextval('public.service_provider_staff_id_seq'::regclass);


--
-- Name: service_providers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers ALTER COLUMN id SET DEFAULT nextval('public.service_providers_id_seq'::regclass);


--
-- Name: subcategories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subcategories ALTER COLUMN id SET DEFAULT nextval('public.subcategories_id_seq'::regclass);


--
-- Name: user_addresses id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_addresses ALTER COLUMN id SET DEFAULT nextval('public.user_addresses_id_seq'::regclass);


--
-- Name: user_group_items id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_items ALTER COLUMN id SET DEFAULT nextval('public.user_group_items_id_seq'::regclass);


--
-- Name: user_group_participants id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_participants ALTER COLUMN id SET DEFAULT nextval('public.user_group_participants_id_seq'::regclass);


--
-- Name: user_groups id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_groups ALTER COLUMN id SET DEFAULT nextval('public.user_groups_id_seq'::regclass);


--
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: neondb_owner
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
\.


--
-- Data for Name: admin_credentials; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.admin_credentials (id, user_id, password_hash, is_active, created_at, updated_at) FROM stdin;
1	admin@123	$2b$10$bw6/4qkfiV0VCFmHj.4GQu.XPNFolnG2sMECJ3v5eXN4f5UcZXh4y	t	2025-09-17 09:05:13.263557	2025-09-17 09:05:13.263557
2	admin	$2b$10$fq/zZajDvac/zhpqSeHTQuWHZSYyhnEeD9aVzAgjbzZUZ/YdlYBOG	t	2025-09-19 09:53:41.196701	2025-09-19 09:53:41.196701
4	viswa968	$2b$10$9CN1Ofn0ojuZH3E4EcgV9.azDlc5HqSAUlNvRufuBckMiTyG/1zJ6	t	2025-09-28 19:32:18.653	2025-09-28 19:32:18.653
5	viswa968@gmail.com	$2b$10$wX0fOpRswlZnfq4zmEUghuXatCL8VD3UVTAEUR/4JlxV1x../DI4S	t	2025-10-01 14:29:39.022819	2025-10-01 14:29:39.022819
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.cart_items (id, user_id, product_id, quantity, added_at) FROM stdin;
55	e053854f-e504-4ac4-9071-9ca5a309bcc4	263	1	2025-09-22 05:56:41.79997
56	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	354	1	2025-09-24 05:59:53.778588
65	cd5c961e-620d-4952-afdf-9bb6c7abe26c	334	11	2025-09-28 19:58:38.45964
66	80eaf7d6-ab44-40ce-8855-8a0660f65bba	354	2	2025-09-29 10:26:54.673651
68	48d7c0f4-1713-4da0-a597-7f687adfe529	365	2	2025-09-29 16:16:51.709342
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.categories (id, name, slug, icon, created_at) FROM stdin;
1	Groceries	groceries	ShoppingCart	2025-08-26 19:08:04.221954
2	Services	services	Briefcase	2025-08-26 19:08:04.221954
3	Pet Essentials	pet-essentials	Heart	2025-09-26 14:38:42.539419
\.


--
-- Data for Name: discount_tiers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.discount_tiers (id, product_id, participant_count, discount_percentage, final_price) FROM stdin;
841	257	5	10.00	26.99
842	257	10	20.00	23.99
843	257	20	35.00	19.49
844	257	30	50.00	14.99
845	258	2	10.00	134.99
846	258	5	20.00	119.99
847	258	10	35.00	97.49
848	258	15	50.00	75.00
849	259	7	10.00	35.99
850	259	15	20.00	31.99
851	259	30	35.00	25.99
852	259	45	50.00	20.00
853	260	0	10.00	71.99
854	260	1	20.00	63.99
855	260	2	35.00	51.99
856	260	3	50.00	39.99
857	261	2	10.00	62.99
858	261	5	20.00	55.99
859	261	10	35.00	45.49
860	261	15	50.00	34.99
861	262	10	10.00	17.99
862	262	20	20.00	15.99
863	262	40	35.00	12.99
864	262	60	50.00	9.99
865	263	4	10.00	269.99
866	263	8	20.00	239.99
867	263	16	35.00	194.99
868	263	24	50.00	150.00
869	264	25	10.00	23.39
870	264	50	20.00	20.79
871	264	100	35.00	16.89
872	264	150	50.00	12.99
873	265	15	10.00	41.39
874	265	30	20.00	36.79
875	265	60	35.00	29.89
876	265	90	50.00	23.00
877	266	12	10.00	80.99
878	266	25	20.00	71.99
879	266	50	35.00	58.49
880	266	75	50.00	44.99
881	267	7	10.00	143.99
882	267	15	20.00	127.99
883	267	30	35.00	103.99
884	267	45	50.00	80.00
885	268	10	10.00	116.99
886	268	20	20.00	103.99
887	268	40	35.00	84.49
888	268	60	50.00	65.00
889	269	20	10.00	35.99
890	269	40	20.00	31.99
891	269	80	35.00	25.99
892	269	120	50.00	20.00
893	270	12	10.00	107.99
894	270	25	20.00	95.99
895	270	50	35.00	77.99
896	270	75	50.00	59.99
897	271	17	10.00	71.99
898	271	35	20.00	63.99
899	271	70	35.00	51.99
900	271	105	50.00	39.99
901	272	6	10.00	179.99
902	272	12	20.00	159.99
903	272	24	35.00	129.99
904	272	36	50.00	100.00
905	273	30	10.00	26.99
906	273	60	20.00	23.99
907	273	120	35.00	19.49
908	273	180	50.00	14.99
909	274	22	10.00	44.99
910	274	45	20.00	39.99
911	274	90	35.00	32.49
912	274	135	50.00	25.00
913	275	5	10.00	224.99
914	275	10	20.00	199.99
915	275	20	35.00	162.49
916	275	30	50.00	125.00
917	276	25	10.00	31.49
918	276	50	20.00	27.99
919	276	100	35.00	22.74
920	276	150	50.00	17.50
921	277	37	10.00	22.49
922	277	75	20.00	19.99
923	277	150	35.00	16.24
924	277	225	50.00	12.49
925	278	50	10.00	17.99
926	278	100	20.00	15.99
927	278	200	35.00	12.99
928	278	300	50.00	9.99
929	279	15	10.00	71.99
930	279	30	20.00	63.99
931	279	60	35.00	51.99
932	279	90	50.00	39.99
933	280	20	10.00	40.49
934	280	40	20.00	35.99
935	280	80	35.00	29.24
936	280	120	50.00	22.50
937	281	17	10.00	53.99
938	281	35	20.00	47.99
939	281	70	35.00	38.99
940	281	105	50.00	30.00
941	282	25	10.00	35.99
942	282	50	20.00	31.99
943	282	100	35.00	25.99
944	282	150	50.00	20.00
945	363	1	35.09	2.96
946	364	4	98.45	0.02
947	365	8	60.52	21.91
\.


--
-- Data for Name: feedback_submissions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.feedback_submissions (id, user_id, feedback_text, image_url, status, created_at) FROM stdin;
\.


--
-- Data for Name: grocery_products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.grocery_products (id, product_id, product_title, product_description, brand, sku_id, sku_code, gtin, barcode_symbology, uom, net_content_value, net_content_uom, is_variable_weight, plu_code, dietary_tags, allergens, country_of_origin, temperature_zone, shelf_life_days, storage_instructions, substitutable, gross_weight_g, list_price_cents, sale_price_cents, effective_from, effective_to, tax_class, inventory_on_hand, inventory_reserved, inventory_status, created_at, updated_at) FROM stdin;
1	283	blue bubble	Premium quality blue bubble with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1599	1599	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:19.014429	2025-09-20 05:04:19.014429
2	284	blue bubble hand soap	Premium quality blue bubble hand soap with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:19.615686	2025-09-20 05:04:19.615686
3	285	blue bubble degreaser	Premium quality blue bubble degreaser with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	899	899	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:20.206554	2025-09-20 05:04:20.206554
4	286	hellmanns mayo	Premium quality hellmanns mayo with excellent value for money.	\N	68400662204	\N	68400662204	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:20.792827	2025-09-20 05:04:20.792827
5	287	nescafe original	Premium quality nescafe original with excellent value for money.	\N	55000710619	\N	55000710619	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	749	749	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:21.371273	2025-09-20 05:04:21.371273
6	288	monster	Premium quality monster with excellent value for money.	\N	70847002901	\N	70847002901	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:21.976789	2025-09-20 05:04:21.976789
7	289	bounty kitchen towel 16 pck	Premium quality bounty kitchen towel 16 pck with excellent value for money.	\N	30772157060	\N	30772157060	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2399	2399	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:22.574845	2025-09-20 05:04:22.574845
8	290	fersca can	Premium quality fersca can with excellent value for money.	\N	679340	\N	679340	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	149	149	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:23.15633	2025-09-20 05:04:23.15633
9	291	lx sella xl basmati 20lb	Premium quality lx sella xl basmati 20lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2299	2299	\N	\N	\N	30	0	in_stock	2025-09-20 05:04:23.739305	2025-09-20 05:04:23.739305
10	292	moms magic cashew and almond	Premium quality moms magic cashew and almond with excellent value for money.	\N	8.41905E+11	\N	8.41905E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	349	349	\N	\N	\N	35	0	in_stock	2025-09-20 05:04:24.378836	2025-09-20 05:04:24.378836
11	293	kawan chapati oat 24pcs	Premium quality kawan chapati oat 24pcs with excellent value for money.	\N	9.55659E+12	\N	9.55659E+12	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	999	999	\N	\N	\N	11	0	in_stock	2025-09-20 05:04:24.989721	2025-09-20 05:04:24.989721
12	294	ak masala dosa	Premium quality ak masala dosa with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:25.565142	2025-09-20 05:04:25.565142
13	295	lx tindora 2lb	Premium quality lx tindora 2lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	649	649	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:26.15117	2025-09-20 05:04:26.15117
14	296	phool makhana 400gm	Premium quality phool makhana 400gm with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1799	1799	\N	\N	\N	9	0	in_stock	2025-09-20 05:04:26.740901	2025-09-20 05:04:26.740901
15	297	till laddu	Premium quality till laddu with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	329	329	\N	\N	\N	17	0	in_stock	2025-09-20 05:04:27.346086	2025-09-20 05:04:27.346086
16	298	lx red chilli powder 800gms	Premium quality lx red chilli powder 800gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1399	1399	\N	\N	\N	10	0	in_stock	2025-09-20 05:04:27.940083	2025-09-20 05:04:27.940083
17	299	whole nut meg 100gms	Premium quality whole nut meg 100gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	19	0	in_stock	2025-09-20 05:04:28.520255	2025-09-20 05:04:28.520255
18	300	dairy milk fire works	Premium quality dairy milk fire works with excellent value for money.	\N	61200018608	\N	61200018608	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	199	199	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:29.109595	2025-09-20 05:04:29.109595
19	301	lysol kitchen pro	Premium quality lysol kitchen pro with excellent value for money.	\N	59631970671	\N	59631970671	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:29.715164	2025-09-20 05:04:29.715164
20	302	lysol	Premium quality lysol with excellent value for money.	\N	59631882936	\N	59631882936	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:30.305303	2025-09-20 05:04:30.305303
21	303	blue bubble	Premium quality blue bubble with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1599	1599	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:50.392519	2025-09-20 05:04:50.392519
22	304	blue bubble hand soap	Premium quality blue bubble hand soap with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:51.00981	2025-09-20 05:04:51.00981
23	305	blue bubble degreaser	Premium quality blue bubble degreaser with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	899	899	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:51.600027	2025-09-20 05:04:51.600027
24	306	hellmanns mayo	Premium quality hellmanns mayo with excellent value for money.	\N	68400662204	\N	68400662204	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:52.190283	2025-09-20 05:04:52.190283
25	307	nescafe original	Premium quality nescafe original with excellent value for money.	\N	55000710619	\N	55000710619	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	749	749	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:52.782278	2025-09-20 05:04:52.782278
26	308	monster	Premium quality monster with excellent value for money.	\N	70847002901	\N	70847002901	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:53.377717	2025-09-20 05:04:53.377717
27	309	bounty kitchen towel 16 pck	Premium quality bounty kitchen towel 16 pck with excellent value for money.	\N	30772157060	\N	30772157060	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2399	2399	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:53.96576	2025-09-20 05:04:53.96576
28	310	fersca can	Premium quality fersca can with excellent value for money.	\N	679340	\N	679340	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	149	149	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:54.580439	2025-09-20 05:04:54.580439
29	311	lx sella xl basmati 20lb	Premium quality lx sella xl basmati 20lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2299	2299	\N	\N	\N	30	0	in_stock	2025-09-20 05:04:55.175398	2025-09-20 05:04:55.175398
30	312	moms magic cashew and almond	Premium quality moms magic cashew and almond with excellent value for money.	\N	8.41905E+11	\N	8.41905E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	349	349	\N	\N	\N	35	0	in_stock	2025-09-20 05:04:55.785803	2025-09-20 05:04:55.785803
31	313	kawan chapati oat 24pcs	Premium quality kawan chapati oat 24pcs with excellent value for money.	\N	9.55659E+12	\N	9.55659E+12	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	999	999	\N	\N	\N	11	0	in_stock	2025-09-20 05:04:56.391685	2025-09-20 05:04:56.391685
32	314	ak masala dosa	Premium quality ak masala dosa with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:56.992511	2025-09-20 05:04:56.992511
33	315	lx tindora 2lb	Premium quality lx tindora 2lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	649	649	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:04:57.583207	2025-09-20 05:04:57.583207
34	316	phool makhana 400gm	Premium quality phool makhana 400gm with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1799	1799	\N	\N	\N	9	0	in_stock	2025-09-20 05:04:58.190884	2025-09-20 05:04:58.190884
35	317	till laddu	Premium quality till laddu with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	329	329	\N	\N	\N	17	0	in_stock	2025-09-20 05:04:58.795546	2025-09-20 05:04:58.795546
36	318	lx red chilli powder 800gms	Premium quality lx red chilli powder 800gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1399	1399	\N	\N	\N	10	0	in_stock	2025-09-20 05:04:59.383358	2025-09-20 05:04:59.383358
37	319	whole nut meg 100gms	Premium quality whole nut meg 100gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	19	0	in_stock	2025-09-20 05:04:59.974024	2025-09-20 05:04:59.974024
38	320	dairy milk fire works	Premium quality dairy milk fire works with excellent value for money.	\N	61200018608	\N	61200018608	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	199	199	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:05:00.580622	2025-09-20 05:05:00.580622
160	443	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:47.139	2025-09-29 16:24:47.139
39	321	lysol kitchen pro	Premium quality lysol kitchen pro with excellent value for money.	\N	59631970671	\N	59631970671	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:05:01.17479	2025-09-20 05:05:01.17479
40	322	lysol	Premium quality lysol with excellent value for money.	\N	59631882936	\N	59631882936	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:05:01.831077	2025-09-20 05:05:01.831077
41	323	blue bubble	Premium quality blue bubble with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1599	1599	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:06:58.473342	2025-09-20 05:06:58.473342
42	324	blue bubble hand soap	Premium quality blue bubble hand soap with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:06:59.082768	2025-09-20 05:06:59.082768
43	325	blue bubble degreaser	Premium quality blue bubble degreaser with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	899	899	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:06:59.687369	2025-09-20 05:06:59.687369
44	326	hellmanns mayo	Premium quality hellmanns mayo with excellent value for money.	\N	68400662204	\N	68400662204	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:00.277568	2025-09-20 05:07:00.277568
45	327	nescafe original	Premium quality nescafe original with excellent value for money.	\N	55000710619	\N	55000710619	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	749	749	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:00.919784	2025-09-20 05:07:00.919784
46	328	monster	Premium quality monster with excellent value for money.	\N	70847002901	\N	70847002901	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:01.539101	2025-09-20 05:07:01.539101
47	329	bounty kitchen towel 16 pck	Premium quality bounty kitchen towel 16 pck with excellent value for money.	\N	30772157060	\N	30772157060	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2399	2399	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:02.148317	2025-09-20 05:07:02.148317
48	330	fersca can	Premium quality fersca can with excellent value for money.	\N	679340	\N	679340	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	149	149	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:02.819965	2025-09-20 05:07:02.819965
49	331	lx sella xl basmati 20lb	Premium quality lx sella xl basmati 20lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2299	2299	\N	\N	\N	30	0	in_stock	2025-09-20 05:07:03.448107	2025-09-20 05:07:03.448107
50	332	moms magic cashew and almond	Premium quality moms magic cashew and almond with excellent value for money.	\N	8.41905E+11	\N	8.41905E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	349	349	\N	\N	\N	35	0	in_stock	2025-09-20 05:07:04.047633	2025-09-20 05:07:04.047633
51	333	kawan chapati oat 24pcs	Premium quality kawan chapati oat 24pcs with excellent value for money.	\N	9.55659E+12	\N	9.55659E+12	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	999	999	\N	\N	\N	11	0	in_stock	2025-09-20 05:07:04.633435	2025-09-20 05:07:04.633435
52	334	ak masala dosa	Premium quality ak masala dosa with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:05.215904	2025-09-20 05:07:05.215904
53	335	lx tindora 2lb	Premium quality lx tindora 2lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	649	649	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:05.80384	2025-09-20 05:07:05.80384
54	336	phool makhana 400gm	Premium quality phool makhana 400gm with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1799	1799	\N	\N	\N	9	0	in_stock	2025-09-20 05:07:06.392335	2025-09-20 05:07:06.392335
55	337	till laddu	Premium quality till laddu with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	329	329	\N	\N	\N	17	0	in_stock	2025-09-20 05:07:06.972821	2025-09-20 05:07:06.972821
56	338	lx red chilli powder 800gms	Premium quality lx red chilli powder 800gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1399	1399	\N	\N	\N	10	0	in_stock	2025-09-20 05:07:07.565121	2025-09-20 05:07:07.565121
57	339	whole nut meg 100gms	Premium quality whole nut meg 100gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	19	0	in_stock	2025-09-20 05:07:08.147664	2025-09-20 05:07:08.147664
58	340	dairy milk fire works	Premium quality dairy milk fire works with excellent value for money.	\N	61200018608	\N	61200018608	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	199	199	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:08.740366	2025-09-20 05:07:08.740366
59	341	lysol kitchen pro	Premium quality lysol kitchen pro with excellent value for money.	\N	59631970671	\N	59631970671	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:09.323164	2025-09-20 05:07:09.323164
60	342	lysol	Premium quality lysol with excellent value for money.	\N	59631882936	\N	59631882936	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:07:09.920441	2025-09-20 05:07:09.920441
61	343	blue bubble	Premium quality blue bubble with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1599	1599	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:50.400009	2025-09-20 05:09:50.400009
62	344	blue bubble hand soap	Premium quality blue bubble hand soap with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:51.006262	2025-09-20 05:09:51.006262
63	345	blue bubble degreaser	Premium quality blue bubble degreaser with excellent value for money.	\N	8.68457E+11	\N	8.68457E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	899	899	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:51.589231	2025-09-20 05:09:51.589231
64	346	hellmanns mayo	Premium quality hellmanns mayo with excellent value for money.	\N	68400662204	\N	68400662204	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:52.189944	2025-09-20 05:09:52.189944
65	347	nescafe original	Premium quality nescafe original with excellent value for money.	\N	55000710619	\N	55000710619	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	749	749	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:52.776702	2025-09-20 05:09:52.776702
66	348	monster	Premium quality monster with excellent value for money.	\N	70847002901	\N	70847002901	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:53.37196	2025-09-20 05:09:53.37196
67	349	bounty kitchen towel 16 pck	Premium quality bounty kitchen towel 16 pck with excellent value for money.	\N	30772157060	\N	30772157060	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2399	2399	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:53.957804	2025-09-20 05:09:53.957804
68	350	fersca can	Premium quality fersca can with excellent value for money.	\N	679340	\N	679340	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	149	149	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:54.554871	2025-09-20 05:09:54.554871
69	351	lx sella xl basmati 20lb	Premium quality lx sella xl basmati 20lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	2299	2299	\N	\N	\N	30	0	in_stock	2025-09-20 05:09:55.140285	2025-09-20 05:09:55.140285
70	352	moms magic cashew and almond	Premium quality moms magic cashew and almond with excellent value for money.	\N	8.41905E+11	\N	8.41905E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	349	349	\N	\N	\N	35	0	in_stock	2025-09-20 05:09:55.724217	2025-09-20 05:09:55.724217
71	353	kawan chapati oat 24pcs	Premium quality kawan chapati oat 24pcs with excellent value for money.	\N	9.55659E+12	\N	9.55659E+12	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	999	999	\N	\N	\N	11	0	in_stock	2025-09-20 05:09:56.307921	2025-09-20 05:09:56.307921
72	354	ak masala dosa	Premium quality ak masala dosa with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	499	499	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:56.919436	2025-09-20 05:09:56.919436
73	355	lx tindora 2lb	Premium quality lx tindora 2lb with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	frozen	\N	\N	t	\N	649	649	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:09:57.521149	2025-09-20 05:09:57.521149
74	356	phool makhana 400gm	Premium quality phool makhana 400gm with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1799	1799	\N	\N	\N	9	0	in_stock	2025-09-20 05:09:58.109186	2025-09-20 05:09:58.109186
75	357	till laddu	Premium quality till laddu with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	329	329	\N	\N	\N	17	0	in_stock	2025-09-20 05:09:58.696787	2025-09-20 05:09:58.696787
76	358	lx red chilli powder 800gms	Premium quality lx red chilli powder 800gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	1399	1399	\N	\N	\N	10	0	in_stock	2025-09-20 05:10:00.074637	2025-09-20 05:10:00.074637
161	444	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:47.692945	2025-09-29 16:24:47.692945
77	359	whole nut meg 100gms	Premium quality whole nut meg 100gms with excellent value for money.	\N	7.23246E+11	\N	7.23246E+11	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	499	499	\N	\N	\N	19	0	in_stock	2025-09-20 05:10:00.673172	2025-09-20 05:10:00.673172
78	360	dairy milk fire works	Premium quality dairy milk fire works with excellent value for money.	\N	61200018608	\N	61200018608	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	199	199	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:10:01.292364	2025-09-20 05:10:01.292364
79	361	lysol kitchen pro	Premium quality lysol kitchen pro with excellent value for money.	\N	59631970671	\N	59631970671	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:10:01.908158	2025-09-20 05:10:01.908158
80	362	lysol	Premium quality lysol with excellent value for money.	\N	59631882936	\N	59631882936	\N	\N	\N	\N	f	\N	\N	\N	\N	ambient	\N	\N	t	\N	699	699	\N	\N	\N	0	0	out_of_stock	2025-09-20 05:10:02.490383	2025-09-20 05:10:02.490383
81	363	\N	\N	test	\N	\N	\N	\N	\N	\N	\N	f	\N	test	dairy,nuts		\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-24 15:44:16.594372	2025-09-24 15:44:16.594372
82	364	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-25 09:06:30.620689	2025-09-25 09:06:30.620689
83	366	\N	\N		\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 10:49:58.609098	2025-09-28 10:49:58.609098
84	367	\N	\N		\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 10:49:59.145992	2025-09-28 10:49:59.145992
85	368	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:02.621336	2025-09-28 21:08:02.621336
86	369	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:03.147997	2025-09-28 21:08:03.147997
87	370	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:03.7879	2025-09-28 21:08:03.7879
88	371	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:04.402926	2025-09-28 21:08:04.402926
89	372	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:06.264623	2025-09-28 21:08:06.264623
90	373	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:06.843218	2025-09-28 21:08:06.843218
91	374	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:07.962406	2025-09-28 21:08:07.962406
92	375	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:08.616682	2025-09-28 21:08:08.616682
93	376	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:09.241009	2025-09-28 21:08:09.241009
94	377	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:09.7666	2025-09-28 21:08:09.7666
95	378	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:10.270556	2025-09-28 21:08:10.270556
96	379	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:11.118961	2025-09-28 21:08:11.118961
97	380	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:11.743538	2025-09-28 21:08:11.743538
98	381	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:12.225265	2025-09-28 21:08:12.225265
99	382	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:12.800108	2025-09-28 21:08:12.800108
100	383	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:13.518822	2025-09-28 21:08:13.518822
101	384	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:13.983622	2025-09-28 21:08:13.983622
102	385	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:14.667443	2025-09-28 21:08:14.667443
103	386	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:15.168346	2025-09-28 21:08:15.168346
104	387	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:15.799465	2025-09-28 21:08:15.799465
105	388	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:16.427667	2025-09-28 21:08:16.427667
106	389	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:16.995262	2025-09-28 21:08:16.995262
107	390	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:17.482266	2025-09-28 21:08:17.482266
108	391	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:17.97744	2025-09-28 21:08:17.97744
109	392	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:18.603768	2025-09-28 21:08:18.603768
110	393	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:19.075309	2025-09-28 21:08:19.075309
111	394	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:19.576457	2025-09-28 21:08:19.576457
112	395	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:20.373859	2025-09-28 21:08:20.373859
113	396	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:21.00832	2025-09-28 21:08:21.00832
114	397	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:21.607835	2025-09-28 21:08:21.607835
115	398	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:22.121008	2025-09-28 21:08:22.121008
116	399	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:23.646568	2025-09-28 21:08:23.646568
117	400	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:24.11973	2025-09-28 21:08:24.11973
118	401	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:24.616362	2025-09-28 21:08:24.616362
119	402	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:25.189949	2025-09-28 21:08:25.189949
120	403	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:26.722925	2025-09-28 21:08:26.722925
121	404	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:27.334977	2025-09-28 21:08:27.334977
122	405	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:27.861159	2025-09-28 21:08:27.861159
123	406	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:28.374387	2025-09-28 21:08:28.374387
124	407	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:28.858883	2025-09-28 21:08:28.858883
125	408	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:29.383431	2025-09-28 21:08:29.383431
126	409	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:29.930419	2025-09-28 21:08:29.930419
127	410	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:30.400026	2025-09-28 21:08:30.400026
128	411	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:30.904242	2025-09-28 21:08:30.904242
129	412	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:31.43414	2025-09-28 21:08:31.43414
130	413	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:32.034234	2025-09-28 21:08:32.034234
131	414	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:32.671882	2025-09-28 21:08:32.671882
132	415	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:33.143797	2025-09-28 21:08:33.143797
133	416	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:33.788333	2025-09-28 21:08:33.788333
134	417	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:34.401216	2025-09-28 21:08:34.401216
135	418	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:35.838089	2025-09-28 21:08:35.838089
136	419	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:36.447066	2025-09-28 21:08:36.447066
137	420	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:37.065799	2025-09-28 21:08:37.065799
138	421	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:37.775464	2025-09-28 21:08:37.775464
139	422	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:38.23761	2025-09-28 21:08:38.23761
140	423	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:38.815854	2025-09-28 21:08:38.815854
141	424	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:39.420685	2025-09-28 21:08:39.420685
142	425	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:40.033702	2025-09-28 21:08:40.033702
143	426	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:40.655025	2025-09-28 21:08:40.655025
144	427	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-28 21:08:41.265361	2025-09-28 21:08:41.265361
145	428	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:39.0736	2025-09-29 16:24:39.0736
146	429	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:39.62083	2025-09-29 16:24:39.62083
147	430	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:40.518361	2025-09-29 16:24:40.518361
148	431	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:40.99397	2025-09-29 16:24:40.99397
149	432	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:41.466372	2025-09-29 16:24:41.466372
150	433	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:41.955773	2025-09-29 16:24:41.955773
151	434	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:42.479995	2025-09-29 16:24:42.479995
152	435	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:43.310348	2025-09-29 16:24:43.310348
153	436	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:43.787229	2025-09-29 16:24:43.787229
154	437	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:44.249084	2025-09-29 16:24:44.249084
155	438	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:44.720603	2025-09-29 16:24:44.720603
156	439	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:45.250777	2025-09-29 16:24:45.250777
157	440	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:45.733797	2025-09-29 16:24:45.733797
158	441	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:46.233483	2025-09-29 16:24:46.233483
159	442	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:46.698155	2025-09-29 16:24:46.698155
162	445	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:48.165538	2025-09-29 16:24:48.165538
163	446	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:48.684366	2025-09-29 16:24:48.684366
164	447	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:49.17874	2025-09-29 16:24:49.17874
165	448	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:49.727615	2025-09-29 16:24:49.727615
166	449	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:50.265963	2025-09-29 16:24:50.265963
167	450	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:50.739787	2025-09-29 16:24:50.739787
168	451	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:51.199859	2025-09-29 16:24:51.199859
169	452	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:51.713534	2025-09-29 16:24:51.713534
170	453	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:52.174983	2025-09-29 16:24:52.174983
171	454	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:52.641967	2025-09-29 16:24:52.641967
172	455	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:53.169302	2025-09-29 16:24:53.169302
173	456	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:53.625921	2025-09-29 16:24:53.625921
174	457	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:54.078235	2025-09-29 16:24:54.078235
175	458	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:54.68899	2025-09-29 16:24:54.68899
176	459	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:55.191796	2025-09-29 16:24:55.191796
177	460	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:55.647513	2025-09-29 16:24:55.647513
178	461	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:56.110873	2025-09-29 16:24:56.110873
179	462	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:56.569406	2025-09-29 16:24:56.569406
180	463	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:57.087518	2025-09-29 16:24:57.087518
181	464	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:57.672579	2025-09-29 16:24:57.672579
182	465	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:58.234136	2025-09-29 16:24:58.234136
183	466	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:58.684069	2025-09-29 16:24:58.684069
184	467	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:59.153929	2025-09-29 16:24:59.153929
185	468	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:24:59.653153	2025-09-29 16:24:59.653153
186	469	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:00.103067	2025-09-29 16:25:00.103067
187	470	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:00.621333	2025-09-29 16:25:00.621333
188	471	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:01.387089	2025-09-29 16:25:01.387089
189	472	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:01.889972	2025-09-29 16:25:01.889972
190	473	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:02.365622	2025-09-29 16:25:02.365622
191	474	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:02.896138	2025-09-29 16:25:02.896138
192	475	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:03.348163	2025-09-29 16:25:03.348163
193	476	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:03.842672	2025-09-29 16:25:03.842672
194	477	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:04.301104	2025-09-29 16:25:04.301104
195	478	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:04.754824	2025-09-29 16:25:04.754824
196	479	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:05.226592	2025-09-29 16:25:05.226592
197	480	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:05.722362	2025-09-29 16:25:05.722362
198	481	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:06.211709	2025-09-29 16:25:06.211709
199	482	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:06.692222	2025-09-29 16:25:06.692222
200	483	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:07.230592	2025-09-29 16:25:07.230592
201	484	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:07.727982	2025-09-29 16:25:07.727982
202	485	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:08.175425	2025-09-29 16:25:08.175425
203	486	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:08.643031	2025-09-29 16:25:08.643031
204	487	\N	\N	Grocery	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	0	0	in_stock	2025-09-29 16:25:09.111983	2025-09-29 16:25:09.111983
\.


--
-- Data for Name: group_payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.group_payments (id, user_id, user_group_id, product_id, stripe_payment_intent_id, amount, currency, status, quantity, unit_price, created_at, updated_at, payer_id) FROM stdin;
8	e053854f-e504-4ac4-9071-9ca5a309bcc4	94	354	\N	4.99	usd	succeeded	1	4.99	2025-09-22 06:23:28.141678	2025-09-22 06:23:28.141678	e053854f-e504-4ac4-9071-9ca5a309bcc4
10	eb73e681-b4a4-489a-bfed-3669d774f217	94	354	pi_1SA3F3AE9e4UchUCLaav5ihE	40.98	usd	pending	1	40.98	2025-09-22 06:28:54.087253	2025-09-22 06:28:54.087253	eb73e681-b4a4-489a-bfed-3669d774f217
16	64e7c3c0-f155-4739-92da-5dc209d9ee40	94	259	\N	35.99	usd	succeeded	1	35.99	2025-09-23 15:02:25.420634	2025-09-23 15:02:25.420634	e053854f-e504-4ac4-9071-9ca5a309bcc4
18	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAXvwAE9e4UchUCi7hdM05Z	40.98	usd	pending	1	40.98	2025-09-23 15:15:12.592664	2025-09-23 15:15:12.592664	e053854f-e504-4ac4-9071-9ca5a309bcc4
21	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAXyBAE9e4UchUCqKzoCJQk	40.98	usd	pending	1	40.98	2025-09-23 15:17:31.297796	2025-09-23 15:17:31.297796	e053854f-e504-4ac4-9071-9ca5a309bcc4
23	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAY1mAE9e4UchUCIxi3fR0a	40.98	usd	pending	1	40.98	2025-09-23 15:21:15.283868	2025-09-23 15:21:15.283868	e053854f-e504-4ac4-9071-9ca5a309bcc4
27	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAY66AE9e4UchUCYiMb2HaO	40.98	usd	pending	1	40.98	2025-09-23 15:25:42.655592	2025-09-23 15:25:42.655592	e053854f-e504-4ac4-9071-9ca5a309bcc4
30	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYJ6AE9e4UchUCBXyCD3CZ	40.98	usd	pending	1	40.98	2025-09-23 15:39:08.640969	2025-09-23 15:39:08.640969	e053854f-e504-4ac4-9071-9ca5a309bcc4
32	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYK5AE9e4UchUCnAMGmrEc	40.98	usd	pending	1	40.98	2025-09-23 15:40:10.015054	2025-09-23 15:40:10.015054	e053854f-e504-4ac4-9071-9ca5a309bcc4
33	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYKCAE9e4UchUCC6KWkaNI	40.98	usd	pending	1	40.98	2025-09-23 15:40:16.781937	2025-09-23 15:40:16.781937	e053854f-e504-4ac4-9071-9ca5a309bcc4
35	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYKUAE9e4UchUCojrnSar2	65.98	usd	pending	1	65.98	2025-09-23 15:40:34.775253	2025-09-23 15:40:34.775253	e053854f-e504-4ac4-9071-9ca5a309bcc4
39	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYNuAE9e4UchUC8aGnV5uf	65.98	usd	pending	1	65.98	2025-09-23 15:44:06.570543	2025-09-23 15:44:06.570543	e053854f-e504-4ac4-9071-9ca5a309bcc4
41	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYTDAE9e4UchUCmY8nqDb1	65.98	usd	pending	1	65.98	2025-09-23 15:49:35.709205	2025-09-23 15:49:35.709205	e053854f-e504-4ac4-9071-9ca5a309bcc4
43	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYTJAE9e4UchUCpPPBgf0p	65.98	usd	pending	1	65.98	2025-09-23 15:49:41.456737	2025-09-23 15:49:41.456737	e053854f-e504-4ac4-9071-9ca5a309bcc4
44	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYTOAE9e4UchUC4VpLJu9Q	65.98	usd	pending	1	65.98	2025-09-23 15:49:47.009754	2025-09-23 15:49:47.009754	e053854f-e504-4ac4-9071-9ca5a309bcc4
45	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYUDAE9e4UchUCxYGv8LWB	40.98	usd	pending	1	40.98	2025-09-23 15:50:37.915502	2025-09-23 15:50:37.915502	e053854f-e504-4ac4-9071-9ca5a309bcc4
47	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYv9AE9e4UchUCnwzVG9aG	40.98	usd	pending	1	40.98	2025-09-23 16:18:27.949281	2025-09-23 16:18:27.949281	e053854f-e504-4ac4-9071-9ca5a309bcc4
49	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAYvdAE9e4UchUCLCcOnwqK	265.98	usd	pending	1	265.98	2025-09-23 16:18:57.968971	2025-09-23 16:18:57.968971	e053854f-e504-4ac4-9071-9ca5a309bcc4
50	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAZ3NAE9e4UchUCOtCPHPYD	40.98	usd	pending	1	40.98	2025-09-23 16:26:58.034987	2025-09-23 16:26:58.034987	e053854f-e504-4ac4-9071-9ca5a309bcc4
52	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAZ3WAE9e4UchUCXabpPM9A	47.13	usd	pending	1	47.13	2025-09-23 16:27:07.292277	2025-09-23 16:27:07.292277	e053854f-e504-4ac4-9071-9ca5a309bcc4
55	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAZNCAE9e4UchUCdKLSWlMd	47.13	usd	pending	1	47.13	2025-09-23 16:47:26.923204	2025-09-23 16:47:26.923204	e053854f-e504-4ac4-9071-9ca5a309bcc4
56	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAZYiAE9e4UchUChJZ6tW9T	44.98	usd	pending	1	44.98	2025-09-23 16:59:20.856497	2025-09-23 16:59:20.856497	e053854f-e504-4ac4-9071-9ca5a309bcc4
57	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAnnBAE9e4UchUCVNcj5U3c	76.97	usd	pending	1	76.97	2025-09-24 08:11:13.53161	2025-09-24 08:11:13.53161	64e7c3c0-f155-4739-92da-5dc209d9ee40
58	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	pi_1SAnqEAE9e4UchUCbvGEhyus	76.97	usd	pending	1	76.97	2025-09-24 08:14:23.322216	2025-09-24 08:14:23.322216	64e7c3c0-f155-4739-92da-5dc209d9ee40
59	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	354	\N	4.99	usd	succeeded	1	4.99	2025-09-24 08:14:44.791561	2025-09-24 08:14:44.791561	64e7c3c0-f155-4739-92da-5dc209d9ee40
60	cd5c961e-620d-4952-afdf-9bb6c7abe26c	94	259	\N	71.98	usd	succeeded	2	35.99	2025-09-24 08:14:45.178626	2025-09-24 08:14:45.178626	64e7c3c0-f155-4739-92da-5dc209d9ee40
61	eb73e681-b4a4-489a-bfed-3669d774f217	94	354	pi_1SApyCAE9e4UchUCvZB7fb1Q	76.97	usd	pending	1	76.97	2025-09-24 10:30:44.333594	2025-09-24 10:30:44.333594	64e7c3c0-f155-4739-92da-5dc209d9ee40
62	eb73e681-b4a4-489a-bfed-3669d774f217	94	354	\N	4.99	usd	succeeded	1	4.99	2025-09-24 10:31:04.926687	2025-09-24 10:31:04.926687	64e7c3c0-f155-4739-92da-5dc209d9ee40
63	eb73e681-b4a4-489a-bfed-3669d774f217	94	259	\N	71.98	usd	succeeded	2	35.99	2025-09-24 10:31:05.209508	2025-09-24 10:31:05.209508	64e7c3c0-f155-4739-92da-5dc209d9ee40
64	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SClbzAE9e4UchUCtebWcYZy	76.97	usd	pending	1	76.97	2025-09-29 18:15:47.426954	2025-09-29 18:15:47.426954	e053854f-e504-4ac4-9071-9ca5a309bcc4
65	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SClkQAE9e4UchUC4hrYIMKw	76.97	usd	pending	1	76.97	2025-09-29 18:24:31.146748	2025-09-29 18:24:31.146748	e053854f-e504-4ac4-9071-9ca5a309bcc4
66	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SCm1pAE9e4UchUCbmhonw4m	76.97	usd	pending	1	76.97	2025-09-29 18:42:29.306859	2025-09-29 18:42:29.306859	e053854f-e504-4ac4-9071-9ca5a309bcc4
67	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SCm98AE9e4UchUC4LXao6dC	76.97	usd	pending	1	76.97	2025-09-29 18:50:03.041404	2025-09-29 18:50:03.041404	e053854f-e504-4ac4-9071-9ca5a309bcc4
68	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SCmDYAE9e4UchUCalKvOYSH	76.97	usd	pending	1	76.97	2025-09-29 18:54:36.775206	2025-09-29 18:54:36.775206	e053854f-e504-4ac4-9071-9ca5a309bcc4
69	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SCmKHAE9e4UchUCddZCzHXR	76.97	usd	pending	1	76.97	2025-09-29 19:01:34.141663	2025-09-29 19:01:34.141663	e053854f-e504-4ac4-9071-9ca5a309bcc4
70	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD3LcAE9e4UchUCrG0eaTYv	76.97	usd	pending	1	76.97	2025-09-30 13:12:05.174035	2025-09-30 13:12:05.174035	e053854f-e504-4ac4-9071-9ca5a309bcc4
71	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD47WAE9e4UchUCfINgIVNM	76.97	usd	pending	1	76.97	2025-09-30 14:01:34.474133	2025-09-30 14:01:34.474133	e053854f-e504-4ac4-9071-9ca5a309bcc4
72	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD4DdAE9e4UchUCCmBXNwvc	76.97	usd	pending	1	76.97	2025-09-30 14:07:53.978567	2025-09-30 14:07:53.978567	e053854f-e504-4ac4-9071-9ca5a309bcc4
73	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD4R9AE9e4UchUCiEF4PkTa	76.97	usd	pending	1	76.97	2025-09-30 14:21:51.497027	2025-09-30 14:21:51.497027	e053854f-e504-4ac4-9071-9ca5a309bcc4
74	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD50kAE9e4UchUCy5IMVS4e	76.97	usd	pending	1	76.97	2025-09-30 14:58:38.344592	2025-09-30 14:58:38.344592	e053854f-e504-4ac4-9071-9ca5a309bcc4
75	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD52QAE9e4UchUCgDXgFq18	76.97	usd	pending	1	76.97	2025-09-30 15:00:22.490897	2025-09-30 15:00:22.490897	e053854f-e504-4ac4-9071-9ca5a309bcc4
76	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD588AE9e4UchUCuTziFEtZ	76.97	usd	pending	1	76.97	2025-09-30 15:06:16.683912	2025-09-30 15:06:16.683912	e053854f-e504-4ac4-9071-9ca5a309bcc4
77	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD59GAE9e4UchUCAXKqZk1a	76.97	usd	pending	1	76.97	2025-09-30 15:07:26.705355	2025-09-30 15:07:26.705355	e053854f-e504-4ac4-9071-9ca5a309bcc4
78	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5NwAE9e4UchUCRoOFm4X7	76.97	usd	pending	1	76.97	2025-09-30 15:22:37.005762	2025-09-30 15:22:37.005762	e053854f-e504-4ac4-9071-9ca5a309bcc4
79	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5O2AE9e4UchUCfISSs9pJ	76.97	usd	pending	1	76.97	2025-09-30 15:22:42.682516	2025-09-30 15:22:42.682516	e053854f-e504-4ac4-9071-9ca5a309bcc4
80	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5QXAE9e4UchUCNmWnw5DT	76.97	usd	pending	1	76.97	2025-09-30 15:25:18.185566	2025-09-30 15:25:18.185566	e053854f-e504-4ac4-9071-9ca5a309bcc4
81	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5bAAE9e4UchUCtdIRtzBH	76.97	usd	pending	1	76.97	2025-09-30 15:36:17.509755	2025-09-30 15:36:17.509755	e053854f-e504-4ac4-9071-9ca5a309bcc4
82	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5l5AE9e4UchUCaU4Q0NmO	76.97	usd	pending	1	76.97	2025-09-30 15:46:32.264136	2025-09-30 15:46:32.264136	e053854f-e504-4ac4-9071-9ca5a309bcc4
83	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5oPAE9e4UchUCeTWWoYzk	76.97	usd	pending	1	76.97	2025-09-30 15:49:58.184657	2025-09-30 15:49:58.184657	e053854f-e504-4ac4-9071-9ca5a309bcc4
84	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5tEAE9e4UchUCpJqJQtIH	76.97	usd	pending	1	76.97	2025-09-30 15:54:56.684994	2025-09-30 15:54:56.684994	e053854f-e504-4ac4-9071-9ca5a309bcc4
85	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD5u0AE9e4UchUCsKTPHlvX	76.97	usd	pending	1	76.97	2025-09-30 15:55:45.20296	2025-09-30 15:55:45.20296	e053854f-e504-4ac4-9071-9ca5a309bcc4
86	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	94	354	pi_1SD631AE9e4UchUCsuCbPAfu	76.97	usd	pending	1	76.97	2025-09-30 16:05:03.568041	2025-09-30 16:05:03.568041	e053854f-e504-4ac4-9071-9ca5a309bcc4
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.order_items (id, order_id, product_id, quantity, unit_price, total_price, created_at) FROM stdin;
10	11	354	1	4.99	4.99	2025-09-22 06:23:27.82306
11	11	259	1	35.99	35.99	2025-09-22 06:23:27.82306
12	12	354	1	4.99	4.99	2025-09-22 06:35:02.128952
13	12	259	1	35.99	35.99	2025-09-22 06:35:02.128952
14	13	354	1	4.99	4.99	2025-09-23 15:02:24.227965
15	13	259	1	35.99	35.99	2025-09-23 15:02:24.227965
16	14	354	1	4.99	4.99	2025-09-24 08:14:44.522254
17	14	259	2	35.99	71.98	2025-09-24 08:14:44.522254
18	16	263	2	299.99	599.98	2025-09-24 10:28:02.363103
19	17	354	1	4.99	4.99	2025-09-24 10:31:04.694919
20	17	259	2	35.99	71.98	2025-09-24 10:31:04.694919
21	18	363	1	4.56	4.56	2025-09-24 15:51:06.464007
22	19	363	1	4.56	4.56	2025-09-25 17:56:38.121116
23	20	275	1	249.99	249.99	2025-09-25 18:12:39.166631
24	21	263	1	299.99	299.99	2025-09-25 18:34:23.297031
25	22	367	1	60.00	60.00	2025-09-28 12:58:03.609147
26	23	349	1	23.99	23.99	2025-09-28 18:54:10.922493
27	24	263	1	299.99	299.99	2025-10-07 18:08:32.52938
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.orders (id, user_id, final_price, shipping_address, status, created_at, updated_at, total_price, type, address_id, product_id, quantity, unit_price, payer_id, expected_delivery_date, actual_delivery_date, delivery_method, user_group_id) FROM stdin;
11	e053854f-e504-4ac4-9071-9ca5a309bcc4	40.98	ajkhsd, asjhdgiua, aksdih, iaushd iuhd, United States	completed	2025-09-22 06:23:27.558568	2025-09-22 06:23:27.558568	40.98	group	5	\N	1	\N	e053854f-e504-4ac4-9071-9ca5a309bcc4	\N	\N	delivery	\N
12	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	40.98	fggdt, jhggjhugjhug, 531515, tgfhtgfv tfdthgf, United States	processing	2025-09-22 06:35:01.760718	2025-09-22 06:43:29.294	40.98	group	6	\N	1	\N	eb73e681-b4a4-489a-bfed-3669d774f217	\N	\N	delivery	\N
13	64e7c3c0-f155-4739-92da-5dc209d9ee40	40.98	test aa, 1 Infinite Loop, Cupertino, CA 95014, United States	completed	2025-09-23 15:02:23.971295	2025-09-23 15:02:23.971295	40.98	group	7	\N	1	\N	e053854f-e504-4ac4-9071-9ca5a309bcc4	\N	\N	delivery	\N
14	cd5c961e-620d-4952-afdf-9bb6c7abe26c	76.97	ausd, 665 Clyde Ave,  Mountain View, CA 94014, United States	completed	2025-09-24 08:14:44.275897	2025-09-24 08:14:44.275897	76.97	group	11	\N	1	\N	64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	\N	delivery	\N
15	64e7c3c0-f155-4739-92da-5dc209d9ee40	299.99	\N	completed	2025-09-24 09:09:24.505296	2025-09-24 09:09:24.505296	299.99	individual	11	263	1	299.99	64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	\N	delivery	\N
16	64e7c3c0-f155-4739-92da-5dc209d9ee40	599.98	ausd, 665 Clyde Ave,  Mountain View, CA 94014, United States	completed	2025-09-24 10:28:02.01609	2025-09-24 10:28:02.01609	599.98	individual	11	\N	1	\N	64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	\N	delivery	\N
17	eb73e681-b4a4-489a-bfed-3669d774f217	76.97	ausd, 665 Clyde Ave,  Mountain View, CA 94014, United States	completed	2025-09-24 10:31:04.380665	2025-09-24 10:31:04.380665	76.97	group	11	\N	1	\N	64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	\N	delivery	\N
18	eb73e681-b4a4-489a-bfed-3669d774f217	28.52	fggdt, jhggjhugjhug, 531515, tgfhtgfv tfdthgf, United States	completed	2025-09-24 15:51:06.138893	2025-09-25 05:12:28.52	28.52	individual	6	\N	1	\N	eb73e681-b4a4-489a-bfed-3669d774f217	\N	\N	delivery	\N
19	eb73e681-b4a4-489a-bfed-3669d774f217	4.56	fggdt, 1234 Main Street,  Vancouver, British Columbia V6B 3K9, United States	completed	2025-09-25 17:56:37.773255	2025-09-25 17:56:37.773255	4.56	individual	6	\N	1	\N	eb73e681-b4a4-489a-bfed-3669d774f217	\N	\N	delivery	\N
20	eb73e681-b4a4-489a-bfed-3669d774f217	249.99	fggdt, 1234 Main Street,  Vancouver, British Columbia V6B 3K9, United States	completed	2025-09-25 18:12:38.844456	2025-09-25 18:12:38.844456	249.99	individual	6	\N	1	\N	eb73e681-b4a4-489a-bfed-3669d774f217	\N	\N	delivery	\N
21	eb73e681-b4a4-489a-bfed-3669d774f217	299.99	fggdt, 1234 Main Street,  Vancouver, British Columbia V6B 3K9, United States	completed	2025-09-25 18:34:23.047611	2025-09-25 18:57:14.952	299.99	individual	6	\N	1	\N	eb73e681-b4a4-489a-bfed-3669d774f217	\N	\N	delivery	\N
22	64e7c3c0-f155-4739-92da-5dc209d9ee40	60.00	John Doe, 123 Main St, Apt 4B, Downtown, Vancouver, Vancouver, British Columbia V6B 1A1, Canada	completed	2025-09-28 12:58:03.304433	2025-09-28 13:03:41.563	60.00	individual	13	\N	1	\N	64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	\N	delivery	\N
23	079f8a23-c6f9-4aee-ab58-b8e13cad10b8	23.99	ausd, 123 Main Street, Surrey, British Columbia V6C 1T4, Canada	pending	2025-09-28 18:54:10.636728	2025-09-28 18:54:10.636728	23.99	individual	14	\N	1	\N	079f8a23-c6f9-4aee-ab58-b8e13cad10b8	\N	\N	delivery	\N
24	0ad8c455-0f61-4ec5-b043-ab333de54d34	349.89	ajkhsd, jsdjfklj, Burnaby, BC V5J 5K7, Canada	pending	2025-10-07 18:08:32.238092	2025-10-07 18:08:32.238092	349.89	individual	17	\N	1	\N	0ad8c455-0f61-4ec5-b043-ab333de54d34	\N	\N	delivery	\N
\.


--
-- Data for Name: pet_provider_staff; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.pet_provider_staff (id, pet_provider_id, name, skills, availability, rating, created_at) FROM stdin;
\.


--
-- Data for Name: pet_providers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.pet_providers (id, product_id, legal_name, display_name, service_category, status, license_number, insurance_valid_till, years_in_business, service_mode, address_line_1, address_line_2, locality, region, postal_code, country, service_area_polygon, service_name, duration_minutes, pricing_model, materials_included, tax_class, age_restriction, availability_type, operating_hours, advance_booking_days, cancellation_policy_url, reschedule_allowed, avg_rating, review_count, highlighted_testimonials, insurance_policy_number, liability_waiver_required, health_safety_cert, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.products (id, seller_id, category_id, name, description, image_url, original_price, minimum_participants, maximum_participants, is_active, created_at, updated_at, offer_valid_till, subcategory_id) FROM stdin;
257	sample-seller-123	1	Organic Fresh Vegetables Bundle	Fresh organic vegetables including carrots, broccoli, spinach, and bell peppers. Perfect for healthy cooking and meal prep.	https://images.unsplash.com/photo-1540420773420-3366772f4999?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	29.99	10	100	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
258	sample-seller-123	2	Professional House Cleaning Service	Complete house cleaning service including kitchen, bathrooms, living areas, and bedrooms. Professional cleaners with eco-friendly products.	https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	149.99	5	20	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
260	sample-seller-123	2	Personal Training Session	One-on-one personal training session with certified fitness instructor. Customized workout plan and nutrition guidance.	https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	79.99	1	10	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
261	sample-seller-123	2	Home Tutoring Service	Professional tutoring service for students. Subjects include math, science, and language arts. Experienced educators.	https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	69.99	5	20	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
262	sample-seller-123	1	Artisan Bread Selection	Fresh artisan breads including sourdough, whole grain, and specialty loaves. Baked daily with premium ingredients.	https://images.unsplash.com/photo-1549931319-a545dcf3bc73?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	19.99	20	100	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
263	john-seller-456	1	4K Ultra HD Smart TV	55-inch 4K Ultra HD Smart TV with HDR and built-in streaming apps. Perfect for entertainment.	https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	299.99	8	50	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
264	john-seller-456	1	Wireless Charging Pad	Fast wireless charging pad compatible with all Qi-enabled devices. Sleek and efficient design.	https://images.unsplash.com/photo-1586953208448-b95a79798f07?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	25.99	50	200	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
265	john-seller-456	1	USB-C Hub Multi-Port Adapter	7-in-1 USB-C hub with HDMI, USB 3.0, SD card reader, and fast charging support.	https://images.unsplash.com/photo-1625842268584-8f3296236761?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	45.99	30	150	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
266	john-seller-456	1	Smartphone Camera Lens Kit	Professional smartphone camera lens kit with wide-angle, macro, and telephoto lenses.	https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	89.99	25	100	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
267	john-seller-456	2	Luxury Leather Handbag	Genuine leather handbag with multiple compartments and adjustable strap. Timeless elegance.	https://images.unsplash.com/photo-1584917865442-de89df76afd3?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	159.99	15	75	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
268	john-seller-456	2	Designer Sunglasses	UV protection designer sunglasses with polarized lenses and lightweight titanium frame.	https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	129.99	20	80	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
269	john-seller-456	2	Premium Wool Scarf	Soft cashmere blend scarf in multiple colors. Perfect for any season and occasion.	https://images.unsplash.com/photo-1601924638867-985629389d5b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	39.99	40	180	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
270	john-seller-456	2	Athletic Performance Sneakers	High-performance athletic sneakers with advanced cushioning and breathable mesh design.	https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	119.99	25	120	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
271	john-seller-456	2	Smart Home Security Camera	1080p HD security camera with night vision, motion detection, and smartphone app control.	https://images.unsplash.com/photo-1558618047-3c8c76ca7d13?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	79.99	35	150	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
272	john-seller-456	2	Ceramic Non-Stick Cookware Set	10-piece ceramic non-stick cookware set with heat-resistant handles and dishwasher-safe design.	https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	199.99	12	60	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
273	john-seller-456	2	LED String Lights	50ft waterproof LED string lights with remote control and 8 lighting modes for outdoor decoration.	https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	29.99	60	300	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
274	john-seller-456	2	Bamboo Cutting Board Set	Set of 3 eco-friendly bamboo cutting boards in different sizes with built-in compartments.	https://images.unsplash.com/photo-1594736797933-d0401ba669ba?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	49.99	45	200	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
275	john-seller-456	2	Adjustable Dumbbell Set	Space-saving adjustable dumbbell set with weight range from 5-50 lbs per dumbbell.	https://images.unsplash.com/photo-1571019613914-85f342c6a11e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	249.99	10	40	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
276	john-seller-456	2	Yoga Mat with Carrying Strap	Extra-thick yoga mat with non-slip surface and alignment lines. Includes carrying strap.	https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	34.99	50	250	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
277	john-seller-456	2	Resistance Bands Set	Complete resistance bands set with 5 different resistance levels, handles, and door anchor.	https://images.unsplash.com/photo-1571019613914-85f342c6a11e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	24.99	75	400	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
278	john-seller-456	2	Premium Protein Shaker Bottle	BPA-free protein shaker bottle with mixing ball and measurement marks. Leak-proof design.	https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	19.99	100	500	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
279	john-seller-456	2	Personal Development Book Bundle	Collection of 5 bestselling personal development books including productivity and mindfulness guides.	https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	79.99	30	150	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
280	john-seller-456	2	Business Strategy Masterclass Book	Comprehensive business strategy guide with case studies from successful entrepreneurs and companies.	https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	44.99	40	200	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
281	john-seller-456	2	Cookbook Collection - Healthy Meals	Set of 3 cookbooks featuring healthy recipes, meal prep ideas, and nutrition guides for families.	https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	59.99	35	175	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
282	john-seller-456	2	Children's Educational Book Set	Interactive educational book set for children ages 3-8 with colorful illustrations and learning activities.	https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	39.99	50	250	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
283	sample-seller-123	1	blue bubble	High-quality blue bubble - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	15.99	10	100	t	2025-09-20 05:04:18.694828	2025-09-20 05:04:18.694828	\N	\N
284	sample-seller-123	1	blue bubble hand soap	High-quality blue bubble hand soap - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:19.327694	2025-09-20 05:04:19.327694	\N	\N
285	sample-seller-123	1	blue bubble degreaser	High-quality blue bubble degreaser - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	8.99	10	100	t	2025-09-20 05:04:19.905716	2025-09-20 05:04:19.905716	\N	\N
286	sample-seller-123	1	hellmanns mayo	High-quality hellmanns mayo - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:04:20.499028	2025-09-20 05:04:20.499028	\N	\N
287	sample-seller-123	1	nescafe original	High-quality nescafe original - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	7.49	10	100	t	2025-09-20 05:04:21.084662	2025-09-20 05:04:21.084662	\N	\N
288	sample-seller-123	1	monster	High-quality monster - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:21.672778	2025-09-20 05:04:21.672778	\N	\N
289	sample-seller-123	1	bounty kitchen towel 16 pck	High-quality bounty kitchen towel 16 pck - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	23.99	10	100	t	2025-09-20 05:04:22.27052	2025-09-20 05:04:22.27052	\N	\N
290	sample-seller-123	1	fersca can	High-quality fersca can - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.49	10	100	t	2025-09-20 05:04:22.866321	2025-09-20 05:04:22.866321	\N	\N
291	sample-seller-123	1	lx sella xl basmati 20lb	High-quality lx sella xl basmati 20lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	22.99	10	100	t	2025-09-20 05:04:23.443311	2025-09-20 05:04:23.443311	\N	\N
292	sample-seller-123	1	moms magic cashew and almond	High-quality moms magic cashew and almond - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.49	10	100	t	2025-09-20 05:04:24.033083	2025-09-20 05:04:24.033083	\N	\N
293	sample-seller-123	1	kawan chapati oat 24pcs	High-quality kawan chapati oat 24pcs - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	9.99	10	100	t	2025-09-20 05:04:24.670331	2025-09-20 05:04:24.670331	\N	\N
294	sample-seller-123	1	ak masala dosa	High-quality ak masala dosa - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:25.279101	2025-09-20 05:04:25.279101	\N	\N
295	sample-seller-123	1	lx tindora 2lb	High-quality lx tindora 2lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.49	10	100	t	2025-09-20 05:04:25.857644	2025-09-20 05:04:25.857644	\N	\N
296	sample-seller-123	1	phool makhana 400gm	High-quality phool makhana 400gm - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	17.99	10	100	t	2025-09-20 05:04:26.440131	2025-09-20 05:04:26.440131	\N	\N
297	sample-seller-123	1	till laddu	High-quality till laddu - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.29	10	100	t	2025-09-20 05:04:27.036626	2025-09-20 05:04:27.036626	\N	\N
298	sample-seller-123	1	lx red chilli powder 800gms	High-quality lx red chilli powder 800gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	13.99	10	100	t	2025-09-20 05:04:27.645135	2025-09-20 05:04:27.645135	\N	\N
299	sample-seller-123	1	whole nut meg 100gms	High-quality whole nut meg 100gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:28.227416	2025-09-20 05:04:28.227416	\N	\N
300	sample-seller-123	1	dairy milk fire works	High-quality dairy milk fire works - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.99	10	100	t	2025-09-20 05:04:28.810092	2025-09-20 05:04:28.810092	\N	\N
301	sample-seller-123	1	lysol kitchen pro	High-quality lysol kitchen pro - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:04:29.410552	2025-09-20 05:04:29.410552	\N	\N
302	sample-seller-123	1	lysol	High-quality lysol - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:04:30.017015	2025-09-20 05:04:30.017015	\N	\N
303	sample-seller-123	1	blue bubble	High-quality blue bubble - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	15.99	10	100	t	2025-09-20 05:04:50.093029	2025-09-20 05:04:50.093029	\N	\N
304	sample-seller-123	1	blue bubble hand soap	High-quality blue bubble hand soap - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:50.704823	2025-09-20 05:04:50.704823	\N	\N
305	sample-seller-123	1	blue bubble degreaser	High-quality blue bubble degreaser - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	8.99	10	100	t	2025-09-20 05:04:51.307767	2025-09-20 05:04:51.307767	\N	\N
306	sample-seller-123	1	hellmanns mayo	High-quality hellmanns mayo - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:04:51.899089	2025-09-20 05:04:51.899089	\N	\N
307	sample-seller-123	1	nescafe original	High-quality nescafe original - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	7.49	10	100	t	2025-09-20 05:04:52.48825	2025-09-20 05:04:52.48825	\N	\N
308	sample-seller-123	1	monster	High-quality monster - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:53.078504	2025-09-20 05:04:53.078504	\N	\N
309	sample-seller-123	1	bounty kitchen towel 16 pck	High-quality bounty kitchen towel 16 pck - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	23.99	10	100	t	2025-09-20 05:04:53.676202	2025-09-20 05:04:53.676202	\N	\N
310	sample-seller-123	1	fersca can	High-quality fersca can - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.49	10	100	t	2025-09-20 05:04:54.257835	2025-09-20 05:04:54.257835	\N	\N
311	sample-seller-123	1	lx sella xl basmati 20lb	High-quality lx sella xl basmati 20lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	22.99	10	100	t	2025-09-20 05:04:54.882491	2025-09-20 05:04:54.882491	\N	\N
312	sample-seller-123	1	moms magic cashew and almond	High-quality moms magic cashew and almond - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.49	10	100	t	2025-09-20 05:04:55.481836	2025-09-20 05:04:55.481836	\N	\N
313	sample-seller-123	1	kawan chapati oat 24pcs	High-quality kawan chapati oat 24pcs - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	9.99	10	100	t	2025-09-20 05:04:56.087332	2025-09-20 05:04:56.087332	\N	\N
314	sample-seller-123	1	ak masala dosa	High-quality ak masala dosa - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:56.685917	2025-09-20 05:04:56.685917	\N	\N
315	sample-seller-123	1	lx tindora 2lb	High-quality lx tindora 2lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.49	10	100	t	2025-09-20 05:04:57.288379	2025-09-20 05:04:57.288379	\N	\N
316	sample-seller-123	1	phool makhana 400gm	High-quality phool makhana 400gm - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	17.99	10	100	t	2025-09-20 05:04:57.89066	2025-09-20 05:04:57.89066	\N	\N
317	sample-seller-123	1	till laddu	High-quality till laddu - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.29	10	100	t	2025-09-20 05:04:58.494968	2025-09-20 05:04:58.494968	\N	\N
318	sample-seller-123	1	lx red chilli powder 800gms	High-quality lx red chilli powder 800gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	13.99	10	100	t	2025-09-20 05:04:59.093001	2025-09-20 05:04:59.093001	\N	\N
319	sample-seller-123	1	whole nut meg 100gms	High-quality whole nut meg 100gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:04:59.675221	2025-09-20 05:04:59.675221	\N	\N
320	sample-seller-123	1	dairy milk fire works	High-quality dairy milk fire works - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.99	10	100	t	2025-09-20 05:05:00.283097	2025-09-20 05:05:00.283097	\N	\N
321	sample-seller-123	1	lysol kitchen pro	High-quality lysol kitchen pro - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:05:00.879006	2025-09-20 05:05:00.879006	\N	\N
322	sample-seller-123	1	lysol	High-quality lysol - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:05:01.540358	2025-09-20 05:05:01.540358	\N	\N
323	sample-seller-123	1	blue bubble	High-quality blue bubble - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	15.99	10	100	t	2025-09-20 05:06:58.153546	2025-09-20 05:06:58.153546	\N	\N
324	sample-seller-123	1	blue bubble hand soap	High-quality blue bubble hand soap - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:06:58.794157	2025-09-20 05:06:58.794157	\N	\N
325	sample-seller-123	1	blue bubble degreaser	High-quality blue bubble degreaser - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	8.99	10	100	t	2025-09-20 05:06:59.38105	2025-09-20 05:06:59.38105	\N	\N
326	sample-seller-123	1	hellmanns mayo	High-quality hellmanns mayo - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:06:59.976411	2025-09-20 05:06:59.976411	\N	\N
327	sample-seller-123	1	nescafe original	High-quality nescafe original - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	7.49	10	100	t	2025-09-20 05:07:00.580695	2025-09-20 05:07:00.580695	\N	\N
328	sample-seller-123	1	monster	High-quality monster - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:07:01.223542	2025-09-20 05:07:01.223542	\N	\N
329	sample-seller-123	1	bounty kitchen towel 16 pck	High-quality bounty kitchen towel 16 pck - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	23.99	10	100	t	2025-09-20 05:07:01.854189	2025-09-20 05:07:01.854189	\N	\N
330	sample-seller-123	1	fersca can	High-quality fersca can - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.49	10	100	t	2025-09-20 05:07:02.476557	2025-09-20 05:07:02.476557	\N	\N
331	sample-seller-123	1	lx sella xl basmati 20lb	High-quality lx sella xl basmati 20lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	22.99	10	100	t	2025-09-20 05:07:03.112002	2025-09-20 05:07:03.112002	\N	\N
332	sample-seller-123	1	moms magic cashew and almond	High-quality moms magic cashew and almond - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.49	10	100	t	2025-09-20 05:07:03.73805	2025-09-20 05:07:03.73805	\N	\N
333	sample-seller-123	1	kawan chapati oat 24pcs	High-quality kawan chapati oat 24pcs - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	9.99	10	100	t	2025-09-20 05:07:04.341665	2025-09-20 05:07:04.341665	\N	\N
334	sample-seller-123	1	ak masala dosa	High-quality ak masala dosa - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:07:04.925548	2025-09-20 05:07:04.925548	\N	\N
335	sample-seller-123	1	lx tindora 2lb	High-quality lx tindora 2lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.49	10	100	t	2025-09-20 05:07:05.507664	2025-09-20 05:07:05.507664	\N	\N
336	sample-seller-123	1	phool makhana 400gm	High-quality phool makhana 400gm - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	17.99	10	100	t	2025-09-20 05:07:06.107056	2025-09-20 05:07:06.107056	\N	\N
337	sample-seller-123	1	till laddu	High-quality till laddu - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.29	10	100	t	2025-09-20 05:07:06.686712	2025-09-20 05:07:06.686712	\N	\N
338	sample-seller-123	1	lx red chilli powder 800gms	High-quality lx red chilli powder 800gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	13.99	10	100	t	2025-09-20 05:07:07.265342	2025-09-20 05:07:07.265342	\N	\N
339	sample-seller-123	1	whole nut meg 100gms	High-quality whole nut meg 100gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:07:07.852472	2025-09-20 05:07:07.852472	\N	\N
340	sample-seller-123	1	dairy milk fire works	High-quality dairy milk fire works - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.99	10	100	t	2025-09-20 05:07:08.447355	2025-09-20 05:07:08.447355	\N	\N
341	sample-seller-123	1	lysol kitchen pro	High-quality lysol kitchen pro - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:07:09.032059	2025-09-20 05:07:09.032059	\N	\N
342	sample-seller-123	1	lysol	High-quality lysol - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:07:09.617444	2025-09-20 05:07:09.617444	\N	\N
343	sample-seller-123	1	blue bubble	High-quality blue bubble - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	15.99	10	100	t	2025-09-20 05:09:50.087941	2025-09-20 05:09:50.087941	\N	\N
344	sample-seller-123	1	blue bubble hand soap	High-quality blue bubble hand soap - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:09:50.715031	2025-09-20 05:09:50.715031	\N	\N
345	sample-seller-123	1	blue bubble degreaser	High-quality blue bubble degreaser - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	8.99	10	100	t	2025-09-20 05:09:51.300691	2025-09-20 05:09:51.300691	\N	\N
346	sample-seller-123	1	hellmanns mayo	High-quality hellmanns mayo - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:09:51.894508	2025-09-20 05:09:51.894508	\N	\N
347	sample-seller-123	1	nescafe original	High-quality nescafe original - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	7.49	10	100	t	2025-09-20 05:09:52.484092	2025-09-20 05:09:52.484092	\N	\N
348	sample-seller-123	1	monster	High-quality monster - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:09:53.072104	2025-09-20 05:09:53.072104	\N	\N
349	sample-seller-123	1	bounty kitchen towel 16 pck	High-quality bounty kitchen towel 16 pck - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	23.99	10	100	t	2025-09-20 05:09:53.662182	2025-09-20 05:09:53.662182	\N	\N
350	sample-seller-123	1	fersca can	High-quality fersca can - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.49	10	100	t	2025-09-20 05:09:54.264479	2025-09-20 05:09:54.264479	\N	\N
351	sample-seller-123	1	lx sella xl basmati 20lb	High-quality lx sella xl basmati 20lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	22.99	10	100	t	2025-09-20 05:09:54.847644	2025-09-20 05:09:54.847644	\N	\N
352	sample-seller-123	1	moms magic cashew and almond	High-quality moms magic cashew and almond - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.49	10	100	t	2025-09-20 05:09:55.430328	2025-09-20 05:09:55.430328	\N	\N
353	sample-seller-123	1	kawan chapati oat 24pcs	High-quality kawan chapati oat 24pcs - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	9.99	10	100	t	2025-09-20 05:09:56.011347	2025-09-20 05:09:56.011347	\N	\N
355	sample-seller-123	1	lx tindora 2lb	High-quality lx tindora 2lb - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.49	10	100	t	2025-09-20 05:09:57.224029	2025-09-20 05:09:57.224029	\N	\N
356	sample-seller-123	1	phool makhana 400gm	High-quality phool makhana 400gm - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	17.99	10	100	t	2025-09-20 05:09:57.810521	2025-09-20 05:09:57.810521	\N	\N
357	sample-seller-123	1	till laddu	High-quality till laddu - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	3.29	10	100	t	2025-09-20 05:09:58.396022	2025-09-20 05:09:58.396022	\N	\N
358	sample-seller-123	1	lx red chilli powder 800gms	High-quality lx red chilli powder 800gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	13.99	10	100	t	2025-09-20 05:09:58.989957	2025-09-20 05:09:58.989957	\N	\N
359	sample-seller-123	1	whole nut meg 100gms	High-quality whole nut meg 100gms - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:10:00.373503	2025-09-20 05:10:00.373503	\N	\N
360	sample-seller-123	1	dairy milk fire works	High-quality dairy milk fire works - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	1.99	10	100	t	2025-09-20 05:10:00.966987	2025-09-20 05:10:00.966987	\N	\N
361	sample-seller-123	1	lysol kitchen pro	High-quality lysol kitchen pro - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:10:01.6104	2025-09-20 05:10:01.6104	\N	\N
362	sample-seller-123	1	lysol	High-quality lysol - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	6.99	10	100	t	2025-09-20 05:10:02.197063	2025-09-20 05:10:02.197063	\N	\N
363	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	OneAnt	asdbghjkjhhiu	\N	4.56	1	1000	t	2025-09-24 15:44:16.178825	2025-09-24 15:44:16.178825	\N	\N
364	eb73e681-b4a4-489a-bfed-3669d774f217	1	test	test asjdkasjdiaksjd	\N	1.29	4	1000	t	2025-09-25 09:06:30.349279	2025-09-25 09:06:30.349279	\N	\N
365	c4eae527-82a6-47b4-bdbb-41f346a5073c	3	OneAnt pet essencials	vhjvhyjvuyjhv	\N	55.50	8	1000	t	2025-09-28 07:30:37.825327	2025-09-28 07:30:37.825327	\N	\N
366	c4eae527-82a6-47b4-bdbb-41f346a5073c	3	Test Pet Grooming Service	Professional pet grooming service	https://example.com/grooming.jpg	45.00	2	8	t	2025-09-28 10:49:58.332294	2025-09-28 10:49:58.332294	2025-12-31 00:00:00	\N
367	c4eae527-82a6-47b4-bdbb-41f346a5073c	3	Test Pet Training Service	Basic pet training service	https://example.com/training.jpg	60.00	3	12	t	2025-09-28 10:49:58.897902	2025-09-28 10:49:58.897902	2025-12-31 00:00:00	\N
368	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble	blue bubble	\N	15.99	10	50	t	2025-09-28 21:08:01.453559	2025-09-28 21:08:01.453559	2025-10-28 00:00:00	\N
369	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble hand soap	blue bubble hand soap	\N	4.99	10	50	t	2025-09-28 21:08:02.893174	2025-09-28 21:08:02.893174	2025-10-28 00:00:00	\N
370	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble degreaser	blue bubble degreaser	\N	8.99	10	50	t	2025-09-28 21:08:03.478491	2025-09-28 21:08:03.478491	2025-10-28 00:00:00	\N
371	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	hellmanns mayo	hellmanns mayo	\N	6.99	10	50	t	2025-09-28 21:08:04.043887	2025-09-28 21:08:04.043887	2025-10-28 00:00:00	\N
372	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	nescafe original	nescafe original	\N	7.49	10	50	t	2025-09-28 21:08:05.926942	2025-09-28 21:08:05.926942	2025-10-28 00:00:00	\N
373	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	bounty kitchen towel 16 pck	bounty kitchen towel 16 pck	\N	23.99	10	50	t	2025-09-28 21:08:06.58497	2025-09-28 21:08:06.58497	2025-10-28 00:00:00	\N
374	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx sella xl basmati 20lb	lx sella xl basmati 20lb	\N	22.99	10	50	t	2025-09-28 21:08:07.216347	2025-09-28 21:08:07.216347	2025-10-28 00:00:00	\N
375	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	moms magic cashew and almond	moms magic cashew and almond	\N	3.49	10	50	t	2025-09-28 21:08:08.358479	2025-09-28 21:08:08.358479	2025-10-28 00:00:00	\N
376	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	phool makhana 400gm	phool makhana 400gm	\N	17.99	10	50	t	2025-09-28 21:08:08.963953	2025-09-28 21:08:08.963953	2025-10-28 00:00:00	\N
377	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	till laddu	till laddu	\N	3.29	10	50	t	2025-09-28 21:08:09.519295	2025-09-28 21:08:09.519295	2025-10-28 00:00:00	\N
378	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx red chilli powder 800gms	lx red chilli powder 800gms	\N	13.99	10	50	t	2025-09-28 21:08:10.025541	2025-09-28 21:08:10.025541	2025-10-28 00:00:00	\N
379	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	whole nut meg 100gms	whole nut meg 100gms	\N	4.99	10	50	t	2025-09-28 21:08:10.711579	2025-09-28 21:08:10.711579	2025-10-28 00:00:00	\N
380	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	dairy milk fire works	dairy milk fire works	\N	1.99	10	50	t	2025-09-28 21:08:11.484598	2025-09-28 21:08:11.484598	2025-10-28 00:00:00	\N
381	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lysol kitchen pro	lysol kitchen pro	\N	6.99	10	50	t	2025-09-28 21:08:11.99567	2025-09-28 21:08:11.99567	2025-10-28 00:00:00	\N
382	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lysol	lysol	\N	6.99	10	50	t	2025-09-28 21:08:12.563916	2025-09-28 21:08:12.563916	2025-10-28 00:00:00	\N
383	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	pik-nik tomato chilli	pik-nik tomato chilli	\N	1.99	10	50	t	2025-09-28 21:08:13.192943	2025-09-28 21:08:13.192943	2025-10-28 00:00:00	\N
384	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	chings chicken 65 masala	chings chicken 65 masala	\N	1.49	10	50	t	2025-09-28 21:08:13.751443	2025-09-28 21:08:13.751443	2025-10-28 00:00:00	\N
385	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	tata tea gold 1kg	tata tea gold 1kg	\N	14.99	10	50	t	2025-09-28 21:08:14.311542	2025-09-28 21:08:14.311542	2025-10-28 00:00:00	\N
386	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	eclairs 20pack	eclairs 20pack	\N	3.49	10	50	t	2025-09-28 21:08:14.936658	2025-09-28 21:08:14.936658	2025-10-28 00:00:00	\N
387	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	center fresh 20pack	center fresh 20pack	\N	3.49	10	50	t	2025-09-28 21:08:15.431068	2025-09-28 21:08:15.431068	2025-10-28 00:00:00	\N
388	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	alpenliebe 20pack	alpenliebe 20pack	\N	3.49	10	50	t	2025-09-28 21:08:16.079933	2025-09-28 21:08:16.079933	2025-10-28 00:00:00	\N
389	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	usb to lightning	usb to lightning	\N	12.99	10	50	t	2025-09-28 21:08:16.661357	2025-09-28 21:08:16.661357	2025-10-28 00:00:00	\N
390	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	type c to type c cable	type c to type c cable	\N	12.99	10	50	t	2025-09-28 21:08:17.250428	2025-09-28 21:08:17.250428	2025-10-28 00:00:00	\N
391	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	bounty 2pck	bounty 2pck	\N	5.99	10	50	t	2025-09-28 21:08:17.725215	2025-09-28 21:08:17.725215	2025-10-28 00:00:00	\N
392	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lays oven baked bbq	lays oven baked bbq	\N	4.49	10	50	t	2025-09-28 21:08:18.351403	2025-09-28 21:08:18.351403	2025-10-28 00:00:00	\N
393	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	megh sooji 4lb	megh sooji 4lb	\N	5.99	10	50	t	2025-09-28 21:08:18.838493	2025-09-28 21:08:18.838493	2025-10-28 00:00:00	\N
394	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	safola masala oats	safola masala oats	\N	5.99	10	50	t	2025-09-28 21:08:19.347371	2025-09-28 21:08:19.347371	2025-10-28 00:00:00	\N
395	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Amul Ghee	Amul Ghee	\N	25.99	10	50	t	2025-09-28 21:08:20.030273	2025-09-28 21:08:20.030273	2025-10-28 00:00:00	\N
396	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	sooji coarse 2lb	sooji coarse 2lb	\N	3.49	10	50	t	2025-09-28 21:08:20.659483	2025-09-28 21:08:20.659483	2025-10-28 00:00:00	\N
397	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	amos peelerz pineapple	amos peelerz pineapple	\N	2.99	10	50	t	2025-09-28 21:08:21.293735	2025-09-28 21:08:21.293735	2025-10-28 00:00:00	\N
398	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	amos leelerz lychee	amos leelerz lychee	\N	2.99	10	50	t	2025-09-28 21:08:21.855054	2025-09-28 21:08:21.855054	2025-10-28 00:00:00	\N
399	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	la la salt and vinegar fish crackers	la la salt and vinegar fish crackers	\N	2.49	10	50	t	2025-09-28 21:08:22.418886	2025-09-28 21:08:22.418886	2025-10-28 00:00:00	\N
400	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx chakki atta	lx chakki atta	\N	12.99	10	50	t	2025-09-28 21:08:23.877043	2025-09-28 21:08:23.877043	2025-10-28 00:00:00	\N
401	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	baliwag pork rinds	baliwag pork rinds	\N	2.49	10	50	t	2025-09-28 21:08:24.367623	2025-09-28 21:08:24.367623	2025-10-28 00:00:00	\N
402	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	mawa chikki	mawa chikki	\N	0.35	10	50	t	2025-09-28 21:08:24.880137	2025-09-28 21:08:24.880137	2025-10-28 00:00:00	\N
403	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	golden fish cracker salt and vineger	golden fish cracker salt and vineger	\N	3.99	10	50	t	2025-09-28 21:08:25.498721	2025-09-28 21:08:25.498721	2025-10-28 00:00:00	\N
404	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	hellmanns classic burgar sauce	hellmanns classic burgar sauce	\N	6.99	10	50	t	2025-09-28 21:08:27.034914	2025-09-28 21:08:27.034914	2025-10-28 00:00:00	\N
405	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lays salted chips	lays salted chips	\N	5.99	10	50	t	2025-09-28 21:08:27.61489	2025-09-28 21:08:27.61489	2025-10-28 00:00:00	\N
406	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	becel margarine	becel margarine	\N	8.99	10	50	t	2025-09-28 21:08:28.090764	2025-09-28 21:08:28.090764	2025-10-28 00:00:00	\N
407	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	gay lea butter	gay lea butter	\N	7.99	10	50	t	2025-09-28 21:08:28.624274	2025-09-28 21:08:28.624274	2025-10-28 00:00:00	\N
408	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx rice flour 2lb	lx rice flour 2lb	\N	3.99	10	50	t	2025-09-28 21:08:29.091483	2025-09-28 21:08:29.091483	2025-10-28 00:00:00	\N
409	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano red rajma 2lb	ingrano red rajma 2lb	\N	4.99	10	50	t	2025-09-28 21:08:29.693983	2025-09-28 21:08:29.693983	2025-10-28 00:00:00	\N
410	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	samrat ratlami sev	samrat ratlami sev	\N	3.99	10	50	t	2025-09-28 21:08:30.16766	2025-09-28 21:08:30.16766	2025-10-28 00:00:00	\N
411	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano mixed dal	ingrano mixed dal	\N	4.49	10	50	t	2025-09-28 21:08:30.650614	2025-09-28 21:08:30.650614	2025-10-28 00:00:00	\N
412	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano toor dal oily	ingrano toor dal oily	\N	5.49	10	50	t	2025-09-28 21:08:31.132244	2025-09-28 21:08:31.132244	2025-10-28 00:00:00	\N
413	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano white chole 2lb	ingrano white chole 2lb	\N	4.99	10	50	t	2025-09-28 21:08:31.783068	2025-09-28 21:08:31.783068	2025-10-28 00:00:00	\N
414	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano moong whole 2lb	ingrano moong whole 2lb	\N	4.75	10	50	t	2025-09-28 21:08:32.349913	2025-09-28 21:08:32.349913	2025-10-28 00:00:00	\N
415	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Quick Millet Poha	Quick Millet Poha	\N	1.69	10	50	t	2025-09-28 21:08:32.909367	2025-09-28 21:08:32.909367	2025-10-28 00:00:00	\N
416	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Quick Millet Upma	Quick Millet Upma	\N	1.69	10	50	t	2025-09-28 21:08:33.481944	2025-09-28 21:08:33.481944	2025-10-28 00:00:00	\N
417	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Nilgiri Ginger Garlic paste 750gr	Nilgiri Ginger Garlic paste 750gr	\N	7.59	10	50	t	2025-09-28 21:08:34.107911	2025-09-28 21:08:34.107911	2025-10-28 00:00:00	\N
418	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Nilgiri Matta Rice 22lb/10 kg	Nilgiri Matta Rice 22lb/10 kg	\N	24.99	10	50	t	2025-09-28 21:08:34.658374	2025-09-28 21:08:34.658374	2025-10-28 00:00:00	\N
419	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Corn Bites Chilli 211 gr	Corn Bites Chilli 211 gr	\N	3.59	10	50	t	2025-09-28 21:08:36.139826	2025-09-28 21:08:36.139826	2025-10-28 00:00:00	\N
420	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Corn Bites 211gr	Corn Bites 211gr	\N	3.59	10	50	t	2025-09-28 21:08:36.767679	2025-09-28 21:08:36.767679	2025-10-28 00:00:00	\N
421	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Spicy Garlic peas 300gr	Spicy Garlic peas 300gr	\N	3.99	10	50	t	2025-09-28 21:08:37.442103	2025-09-28 21:08:37.442103	2025-10-28 00:00:00	\N
422	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Tasty nuts 300 gr	Tasty nuts 300 gr	\N	3.99	10	50	t	2025-09-28 21:08:38.007371	2025-09-28 21:08:38.007371	2025-10-28 00:00:00	\N
423	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Muruku 300 gr	Muruku 300 gr	\N	3.99	10	50	t	2025-09-28 21:08:38.466675	2025-09-28 21:08:38.466675	2025-10-28 00:00:00	\N
424	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Siracha Chilli Sauce	Siracha Chilli Sauce	\N	2.99	10	50	t	2025-09-28 21:08:39.127089	2025-09-28 21:08:39.127089	2025-10-28 00:00:00	\N
425	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya Red Chilli Pckl	Priya Red Chilli Pckl	\N	3.10	10	50	t	2025-09-28 21:08:39.738321	2025-09-28 21:08:39.738321	2025-10-28 00:00:00	\N
426	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya Lime Pickle	Priya Lime Pickle	\N	3.10	10	50	t	2025-09-28 21:08:40.34564	2025-09-28 21:08:40.34564	2025-10-28 00:00:00	\N
427	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya ginger pikl 300mg	Priya ginger pikl 300mg	\N	3.10	10	50	t	2025-09-28 21:08:40.965282	2025-09-28 21:08:40.965282	2025-10-28 00:00:00	\N
428	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble	blue bubble	\N	15.99	10	50	t	2025-09-29 16:24:38.787361	2025-09-29 16:24:38.787361	2025-10-29 00:00:00	\N
429	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble hand soap	blue bubble hand soap	\N	4.99	10	50	t	2025-09-29 16:24:39.31027	2025-09-29 16:24:39.31027	2025-10-29 00:00:00	\N
430	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	blue bubble degreaser	blue bubble degreaser	\N	8.99	10	50	t	2025-09-29 16:24:40.282509	2025-09-29 16:24:40.282509	2025-10-29 00:00:00	\N
431	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	hellmanns mayo	hellmanns mayo	\N	6.99	10	50	t	2025-09-29 16:24:40.762312	2025-09-29 16:24:40.762312	2025-10-29 00:00:00	\N
432	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	nescafe original	nescafe original	\N	7.49	10	50	t	2025-09-29 16:24:41.225207	2025-09-29 16:24:41.225207	2025-10-29 00:00:00	\N
433	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	bounty kitchen towel 16 pck	bounty kitchen towel 16 pck	\N	23.99	10	50	t	2025-09-29 16:24:41.718091	2025-09-29 16:24:41.718091	2025-10-29 00:00:00	\N
434	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx sella xl basmati 20lb	lx sella xl basmati 20lb	\N	22.99	10	50	t	2025-09-29 16:24:42.2191	2025-09-29 16:24:42.2191	2025-10-29 00:00:00	\N
435	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	moms magic cashew and almond	moms magic cashew and almond	\N	3.49	10	50	t	2025-09-29 16:24:43.079118	2025-09-29 16:24:43.079118	2025-10-29 00:00:00	\N
436	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	phool makhana 400gm	phool makhana 400gm	\N	17.99	10	50	t	2025-09-29 16:24:43.547463	2025-09-29 16:24:43.547463	2025-10-29 00:00:00	\N
437	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	till laddu	till laddu	\N	3.29	10	50	t	2025-09-29 16:24:44.017861	2025-09-29 16:24:44.017861	2025-10-29 00:00:00	\N
438	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx red chilli powder 800gms	lx red chilli powder 800gms	\N	13.99	10	50	t	2025-09-29 16:24:44.486533	2025-09-29 16:24:44.486533	2025-10-29 00:00:00	\N
439	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	whole nut meg 100gms	whole nut meg 100gms	\N	4.99	10	50	t	2025-09-29 16:24:44.947755	2025-09-29 16:24:44.947755	2025-10-29 00:00:00	\N
440	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	dairy milk fire works	dairy milk fire works	\N	1.99	10	50	t	2025-09-29 16:24:45.481098	2025-09-29 16:24:45.481098	2025-10-29 00:00:00	\N
441	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lysol kitchen pro	lysol kitchen pro	\N	6.99	10	50	t	2025-09-29 16:24:45.962506	2025-09-29 16:24:45.962506	2025-10-29 00:00:00	\N
442	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lysol	lysol	\N	6.99	10	50	t	2025-09-29 16:24:46.460803	2025-09-29 16:24:46.460803	2025-10-29 00:00:00	\N
443	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	pik-nik tomato chilli	pik-nik tomato chilli	\N	1.99	10	50	t	2025-09-29 16:24:46.919599	2025-09-29 16:24:46.919599	2025-10-29 00:00:00	\N
444	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	chings chicken 65 masala	chings chicken 65 masala	\N	1.49	10	50	t	2025-09-29 16:24:47.413919	2025-09-29 16:24:47.413919	2025-10-29 00:00:00	\N
445	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	tata tea gold 1kg	tata tea gold 1kg	\N	14.99	10	50	t	2025-09-29 16:24:47.930095	2025-09-29 16:24:47.930095	2025-10-29 00:00:00	\N
446	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	eclairs 20pack	eclairs 20pack	\N	3.49	10	50	t	2025-09-29 16:24:48.400416	2025-09-29 16:24:48.400416	2025-10-29 00:00:00	\N
447	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	center fresh 20pack	center fresh 20pack	\N	3.49	10	50	t	2025-09-29 16:24:48.929372	2025-09-29 16:24:48.929372	2025-10-29 00:00:00	\N
448	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	alpenliebe 20pack	alpenliebe 20pack	\N	3.49	10	50	t	2025-09-29 16:24:49.45799	2025-09-29 16:24:49.45799	2025-10-29 00:00:00	\N
449	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	usb to lightning	usb to lightning	\N	12.99	10	50	t	2025-09-29 16:24:50.00389	2025-09-29 16:24:50.00389	2025-10-29 00:00:00	\N
450	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	type c to type c cable	type c to type c cable	\N	12.99	10	50	t	2025-09-29 16:24:50.51784	2025-09-29 16:24:50.51784	2025-10-29 00:00:00	\N
451	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	bounty 2pck	bounty 2pck	\N	5.99	10	50	t	2025-09-29 16:24:50.969183	2025-09-29 16:24:50.969183	2025-10-29 00:00:00	\N
452	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lays oven baked bbq	lays oven baked bbq	\N	4.49	10	50	t	2025-09-29 16:24:51.44371	2025-09-29 16:24:51.44371	2025-10-29 00:00:00	\N
453	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	megh sooji 4lb	megh sooji 4lb	\N	5.99	10	50	t	2025-09-29 16:24:51.942581	2025-09-29 16:24:51.942581	2025-10-29 00:00:00	\N
454	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	safola masala oats	safola masala oats	\N	5.99	10	50	t	2025-09-29 16:24:52.410175	2025-09-29 16:24:52.410175	2025-10-29 00:00:00	\N
455	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Amul Ghee	Amul Ghee	\N	25.99	10	50	t	2025-09-29 16:24:52.946194	2025-09-29 16:24:52.946194	2025-10-29 00:00:00	\N
456	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	sooji coarse 2lb	sooji coarse 2lb	\N	3.49	10	50	t	2025-09-29 16:24:53.397282	2025-09-29 16:24:53.397282	2025-10-29 00:00:00	\N
457	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	amos peelerz pineapple	amos peelerz pineapple	\N	2.99	10	50	t	2025-09-29 16:24:53.854702	2025-09-29 16:24:53.854702	2025-10-29 00:00:00	\N
458	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	amos leelerz lychee	amos leelerz lychee	\N	2.99	10	50	t	2025-09-29 16:24:54.428513	2025-09-29 16:24:54.428513	2025-10-29 00:00:00	\N
459	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	la la salt and vinegar fish crackers	la la salt and vinegar fish crackers	\N	2.49	10	50	t	2025-09-29 16:24:54.966808	2025-09-29 16:24:54.966808	2025-10-29 00:00:00	\N
460	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx chakki atta	lx chakki atta	\N	12.99	10	50	t	2025-09-29 16:24:55.41323	2025-09-29 16:24:55.41323	2025-10-29 00:00:00	\N
461	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	baliwag pork rinds	baliwag pork rinds	\N	2.49	10	50	t	2025-09-29 16:24:55.880525	2025-09-29 16:24:55.880525	2025-10-29 00:00:00	\N
462	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	mawa chikki	mawa chikki	\N	0.35	10	50	t	2025-09-29 16:24:56.33547	2025-09-29 16:24:56.33547	2025-10-29 00:00:00	\N
463	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	golden fish cracker salt and vineger	golden fish cracker salt and vineger	\N	3.99	10	50	t	2025-09-29 16:24:56.794034	2025-09-29 16:24:56.794034	2025-10-29 00:00:00	\N
464	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	hellmanns classic burgar sauce	hellmanns classic burgar sauce	\N	6.99	10	50	t	2025-09-29 16:24:57.314747	2025-09-29 16:24:57.314747	2025-10-29 00:00:00	\N
465	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lays salted chips	lays salted chips	\N	5.99	10	50	t	2025-09-29 16:24:57.998427	2025-09-29 16:24:57.998427	2025-10-29 00:00:00	\N
466	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	becel margarine	becel margarine	\N	8.99	10	50	t	2025-09-29 16:24:58.460055	2025-09-29 16:24:58.460055	2025-10-29 00:00:00	\N
467	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	gay lea butter	gay lea butter	\N	7.99	10	50	t	2025-09-29 16:24:58.91872	2025-09-29 16:24:58.91872	2025-10-29 00:00:00	\N
468	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	lx rice flour 2lb	lx rice flour 2lb	\N	3.99	10	50	t	2025-09-29 16:24:59.427638	2025-09-29 16:24:59.427638	2025-10-29 00:00:00	\N
469	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano red rajma 2lb	ingrano red rajma 2lb	\N	4.99	10	50	t	2025-09-29 16:24:59.875812	2025-09-29 16:24:59.875812	2025-10-29 00:00:00	\N
470	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	samrat ratlami sev	samrat ratlami sev	\N	3.99	10	50	t	2025-09-29 16:25:00.351479	2025-09-29 16:25:00.351479	2025-10-29 00:00:00	\N
471	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano mixed dal	ingrano mixed dal	\N	4.49	10	50	t	2025-09-29 16:25:01.15986	2025-09-29 16:25:01.15986	2025-10-29 00:00:00	\N
472	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano toor dal oily	ingrano toor dal oily	\N	5.49	10	50	t	2025-09-29 16:25:01.664192	2025-09-29 16:25:01.664192	2025-10-29 00:00:00	\N
473	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano white chole 2lb	ingrano white chole 2lb	\N	4.99	10	50	t	2025-09-29 16:25:02.13425	2025-09-29 16:25:02.13425	2025-10-29 00:00:00	\N
474	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	ingrano moong whole 2lb	ingrano moong whole 2lb	\N	4.75	10	50	t	2025-09-29 16:25:02.650128	2025-09-29 16:25:02.650128	2025-10-29 00:00:00	\N
475	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Quick Millet Poha	Quick Millet Poha	\N	1.69	10	50	t	2025-09-29 16:25:03.126914	2025-09-29 16:25:03.126914	2025-10-29 00:00:00	\N
476	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Quick Millet Upma	Quick Millet Upma	\N	1.69	10	50	t	2025-09-29 16:25:03.622634	2025-09-29 16:25:03.622634	2025-10-29 00:00:00	\N
477	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Nilgiri Ginger Garlic paste 750gr	Nilgiri Ginger Garlic paste 750gr	\N	7.59	10	50	t	2025-09-29 16:25:04.069918	2025-09-29 16:25:04.069918	2025-10-29 00:00:00	\N
478	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Nilgiri Matta Rice 22lb/10 kg	Nilgiri Matta Rice 22lb/10 kg	\N	24.99	10	50	t	2025-09-29 16:25:04.535479	2025-09-29 16:25:04.535479	2025-10-29 00:00:00	\N
479	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Corn Bites Chilli 211 gr	Corn Bites Chilli 211 gr	\N	3.59	10	50	t	2025-09-29 16:25:04.993287	2025-09-29 16:25:04.993287	2025-10-29 00:00:00	\N
480	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Corn Bites 211gr	Corn Bites 211gr	\N	3.59	10	50	t	2025-09-29 16:25:05.467815	2025-09-29 16:25:05.467815	2025-10-29 00:00:00	\N
481	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Spicy Garlic peas 300gr	Spicy Garlic peas 300gr	\N	3.99	10	50	t	2025-09-29 16:25:05.958878	2025-09-29 16:25:05.958878	2025-10-29 00:00:00	\N
482	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Tasty nuts 300 gr	Tasty nuts 300 gr	\N	3.99	10	50	t	2025-09-29 16:25:06.445857	2025-09-29 16:25:06.445857	2025-10-29 00:00:00	\N
483	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Muruku 300 gr	Muruku 300 gr	\N	3.99	10	50	t	2025-09-29 16:25:06.925389	2025-09-29 16:25:06.925389	2025-10-29 00:00:00	\N
484	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Siracha Chilli Sauce	Siracha Chilli Sauce	\N	2.99	10	50	t	2025-09-29 16:25:07.458743	2025-09-29 16:25:07.458743	2025-10-29 00:00:00	\N
485	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya Red Chilli Pckl	Priya Red Chilli Pckl	\N	3.10	10	50	t	2025-09-29 16:25:07.954725	2025-09-29 16:25:07.954725	2025-10-29 00:00:00	\N
486	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya Lime Pickle	Priya Lime Pickle	\N	3.10	10	50	t	2025-09-29 16:25:08.412743	2025-09-29 16:25:08.412743	2025-10-29 00:00:00	\N
487	e053854f-e504-4ac4-9071-9ca5a309bcc4	1	Priya ginger pikl 300mg	Priya ginger pikl 300mg	\N	3.10	10	50	t	2025-09-29 16:25:08.879312	2025-09-29 16:25:08.879312	2025-10-29 00:00:00	\N
259	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	1	Premium Coffee Beans Selection	High-quality coffee beans from different regions. Perfect for coffee enthusiasts who want to try various flavors and brewing methods.	https://images.unsplash.com/photo-1559056199-641a0ac8b55e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300	39.99	15	150	t	2025-09-19 16:43:59.342014	2025-09-19 16:43:59.342014	\N	\N
354	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	1	ak masala dosa	High-quality ak masala dosa - perfect for your grocery needs.	https://images.unsplash.com/photo-1542838132-92c53300491e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&h=300&q=80	4.99	10	100	t	2025-09-20 05:09:56.626394	2025-09-20 05:09:56.626394	\N	\N
\.


--
-- Data for Name: seller_inquiries; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.seller_inquiries (id, name, phone_number, status, notes, created_at) FROM stdin;
\.


--
-- Data for Name: seller_notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.seller_notifications (id, seller_id, type, title, message, data, is_read, priority, created_at, read_at) FROM stdin;
1	e053854f-e504-4ac4-9071-9ca5a309bcc4	group_join_request	New Join Request	User  wants to join your group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "memberEmail": null, "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 05:58:54.831012	2025-09-22 05:59:34.566
2	64e7c3c0-f155-4739-92da-5dc209d9ee40	request_accepted	Request Accepted! 🎉	Your request to join group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection has been accepted by the group owner.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 05:59:49.859893	2025-09-22 06:01:40.476
4	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	request_accepted	Request Accepted! 🎉	Your request to join group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection has been accepted by the group owner.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "ak masala dosa, Premium Coffee Beans Selection"}	f	normal	2025-09-22 06:12:35.554883	\N
3	e053854f-e504-4ac4-9071-9ca5a309bcc4	group_join_request	New Join Request	User  wants to join your group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "memberEmail": null, "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 06:10:34.971368	2025-09-22 06:17:34.774
5	e053854f-e504-4ac4-9071-9ca5a309bcc4	group_join_request	New Join Request	User  wants to join your group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "memberEmail": null, "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 06:14:23.580602	2025-09-22 06:17:34.774
6	e053854f-e504-4ac4-9071-9ca5a309bcc4	group_join_request	New Join Request	User  wants to join your group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "memberEmail": null, "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 06:16:49.798631	2025-09-22 06:17:34.774
11	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "orderId": 11, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "354, 259", "totalAmount": "40.98"}	f	normal	2025-09-22 06:23:31.240099	\N
9	e053854f-e504-4ac4-9071-9ca5a309bcc4	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "e053854f-e504-4ac4-9071-9ca5a309bcc4", "groupId": 94, "orderId": 11, "groupName": "test group with notification", "memberName": "test owner 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:23:30.703453	2025-09-22 06:25:16.469
8	eb73e681-b4a4-489a-bfed-3669d774f217	request_accepted	Request Accepted! 🎉	Your request to join group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection has been accepted by the group owner.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "groupName": "test group with notification", "memberName": "User ", "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 06:17:26.098604	2025-09-22 06:27:41.236
17	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "orderId": 12, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "354, 259", "totalAmount": "40.98"}	f	normal	2025-09-22 06:35:04.678769	\N
15	e053854f-e504-4ac4-9071-9ca5a309bcc4	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "e053854f-e504-4ac4-9071-9ca5a309bcc4", "groupId": 94, "orderId": 12, "groupName": "test group with notification", "memberName": "test owner 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:35:04.063092	2025-09-22 06:44:19.802
10	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "orderId": 11, "groupName": "test group with notification", "memberName": "test mem 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:23:30.962013	2025-09-24 06:56:00.741
16	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "orderId": 12, "groupName": "test group with notification", "memberName": "test mem 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:35:04.380053	2025-09-24 06:56:00.741
7	cd5c961e-620d-4952-afdf-9bb6c7abe26c	request_accepted	Request Accepted! 🎉	Your request to join group "test group with notification" for ak masala dosa, Premium Coffee Beans Selection has been accepted by the group owner.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "ak masala dosa, Premium Coffee Beans Selection"}	t	normal	2025-09-22 06:17:22.887794	2025-09-27 09:01:53.331
13	eb73e681-b4a4-489a-bfed-3669d774f217	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "orderId": 11, "groupName": "test group with notification", "memberName": "test mem 4 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:23:31.826784	2025-09-22 06:27:41.236
14	sample-seller-123	new_order	New Order Received! 🛒	You have received a new order for products: ak masala dosa, Premium Coffee Beans Selection. Order total: $40.98	{"orderId": 11, "sellerId": "sample-seller-123", "orderType": "group", "sellerName": "John Seller", "productName": "ak masala dosa, Premium Coffee Beans Selection", "totalAmount": "40.98"}	t	high	2025-09-22 06:23:33.488495	2025-09-22 06:40:00.515
21	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_status_change	Order Status Updated 🔄	Your order is being prepared for products: 354, 259.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "orderId": 12, "memberName": "test mem 2 ", "orderStatus": "processing", "productName": "354, 259", "totalAmount": "40.98"}	f	normal	2025-09-22 06:43:32.738885	\N
12	cd5c961e-620d-4952-afdf-9bb6c7abe26c	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "orderId": 11, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:23:31.514731	2025-09-27 09:01:53.331
20	sample-seller-123	new_order	New Order Received! 🛒	You have received a new order for products: ak masala dosa, Premium Coffee Beans Selection. Order total: $40.98	{"orderId": 12, "sellerId": "sample-seller-123", "orderType": "group", "sellerName": "John Seller", "productName": "ak masala dosa, Premium Coffee Beans Selection", "totalAmount": "40.98"}	t	high	2025-09-22 06:35:07.070773	2025-09-22 06:40:00.515
23	buyer-1	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fitness & Wellness Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 87, "name": "Fitness & Wellness Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-1", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:57.256306	\N
24	buyer-2	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fashion Forward Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 88, "name": "Fashion Forward Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-2", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:57.562926	\N
25	buyer-3	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Smart Living Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 89, "name": "Smart Living Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-3", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:57.880101	\N
26	buyer-4	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Gaming & Entertainment" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 90, "name": "Gaming & Entertainment", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-4", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:58.166477	\N
27	buyer-5	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Health & Beauty Kit" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 91, "name": "Health & Beauty Kit", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-5", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:58.49522	\N
28	buyer-6	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Kitchen & Dining Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 92, "name": "Kitchen & Dining Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-6", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:58.781402	\N
29	buyer-7	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Outdoor Adventure Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 93, "name": "Outdoor Adventure Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-7", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:36:59.066786	\N
32	buyer-1	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fitness & Wellness Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 87, "name": "Fitness & Wellness Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-1", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:02.904797	\N
19	eb73e681-b4a4-489a-bfed-3669d774f217	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "orderId": 12, "groupName": "test group with notification", "memberName": "test mem 4 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:35:05.295247	2025-09-24 15:45:30.136
22	john-seller-456	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Home Comfort Collection" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 86, "name": "Home Comfort Collection", "neededMembers": 5, "currentMembers": "0"}], "userId": "john-seller-456", "incompleteGroupsCount": 1}	t	normal	2025-09-22 08:36:56.953276	2025-09-25 18:34:55.636
18	cd5c961e-620d-4952-afdf-9bb6c7abe26c	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "orderId": 12, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-22 06:35:04.957396	2025-09-27 09:01:53.331
33	buyer-2	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fashion Forward Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 88, "name": "Fashion Forward Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-2", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:03.172194	\N
34	buyer-3	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Smart Living Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 89, "name": "Smart Living Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-3", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:03.437391	\N
35	buyer-4	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Gaming & Entertainment" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 90, "name": "Gaming & Entertainment", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-4", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:03.729342	\N
36	buyer-5	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Health & Beauty Kit" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 91, "name": "Health & Beauty Kit", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-5", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:04.044185	\N
37	buyer-6	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Kitchen & Dining Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 92, "name": "Kitchen & Dining Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-6", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:04.329882	\N
38	buyer-7	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Outdoor Adventure Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 93, "name": "Outdoor Adventure Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-7", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:40:04.606053	\N
30	sample-seller-123	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Tech Essentials Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 85, "name": "Tech Essentials Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "sample-seller-123", "incompleteGroupsCount": 1}	t	normal	2025-09-22 08:36:59.4144	2025-09-22 08:42:14.087
39	sample-seller-123	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Tech Essentials Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 85, "name": "Tech Essentials Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "sample-seller-123", "incompleteGroupsCount": 1}	t	normal	2025-09-22 08:40:04.868195	2025-09-22 08:42:14.087
41	buyer-1	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fitness & Wellness Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 87, "name": "Fitness & Wellness Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-1", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:25.200431	\N
42	buyer-2	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Fashion Forward Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 88, "name": "Fashion Forward Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-2", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:25.509085	\N
43	buyer-3	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Smart Living Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 89, "name": "Smart Living Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-3", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:25.810582	\N
44	buyer-4	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Gaming & Entertainment" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 90, "name": "Gaming & Entertainment", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-4", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:26.139193	\N
40	john-seller-456	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Home Comfort Collection" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 86, "name": "Home Comfort Collection", "neededMembers": 5, "currentMembers": "0"}], "userId": "john-seller-456", "incompleteGroupsCount": 1}	t	normal	2025-09-22 08:50:24.915345	2025-09-25 18:34:55.636
45	buyer-5	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Health & Beauty Kit" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 91, "name": "Health & Beauty Kit", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-5", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:26.428966	\N
46	buyer-6	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Kitchen & Dining Set" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 92, "name": "Kitchen & Dining Set", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-6", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:26.715715	\N
47	buyer-7	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Outdoor Adventure Pack" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 93, "name": "Outdoor Adventure Pack", "neededMembers": 5, "currentMembers": "0"}], "userId": "buyer-7", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:26.996272	\N
48	sample-seller-123	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Tech Essentials Bundle" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 85, "name": "Tech Essentials Bundle", "neededMembers": 5, "currentMembers": "0"}], "userId": "sample-seller-123", "incompleteGroupsCount": 1}	f	normal	2025-09-22 08:50:27.277182	\N
51	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "orderId": 13, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "354, 259", "totalAmount": "40.98"}	f	normal	2025-09-23 15:02:27.221136	\N
54	sample-seller-123	new_order	New Order Received! 🛒	You have received a new order for products: ak masala dosa, Premium Coffee Beans Selection. Order total: $40.98	{"orderId": 13, "sellerId": "sample-seller-123", "orderType": "group", "sellerName": "John Seller", "productName": "ak masala dosa, Premium Coffee Beans Selection", "totalAmount": "40.98"}	f	high	2025-09-23 15:02:30.026655	\N
49	e053854f-e504-4ac4-9071-9ca5a309bcc4	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "e053854f-e504-4ac4-9071-9ca5a309bcc4", "groupId": 94, "orderId": 13, "groupName": "test group with notification", "memberName": "test owner 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-23 15:02:26.640394	2025-09-23 15:03:10.864
50	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "orderId": 13, "groupName": "test group with notification", "memberName": "test mem 1 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-23 15:02:26.924414	2025-09-24 06:56:00.741
57	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "orderId": 14, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "354, 259", "totalAmount": "76.97"}	f	normal	2025-09-24 08:14:48.564949	\N
53	eb73e681-b4a4-489a-bfed-3669d774f217	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "orderId": 13, "groupName": "test group with notification", "memberName": "test mem 4 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-23 15:02:27.7088	2025-09-24 15:45:30.136
55	e053854f-e504-4ac4-9071-9ca5a309bcc4	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "e053854f-e504-4ac4-9071-9ca5a309bcc4", "groupId": 94, "orderId": 14, "groupName": "test group with notification", "memberName": "test owner 1 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 08:14:47.977932	2025-09-24 14:44:16.722
74	john-seller-456	payment_received	Payment Received	Payment of $299.99 received for: 4K Ultra HD Smart TV (Order #21)	{"amount": 299.99, "orderId": 21, "productIds": [null]}	t	high	2025-09-25 18:34:23.808274	2025-09-25 18:34:55.636
76	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated 🚛	Your order is out for delivery for products: 263.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 21, "memberName": "test mem 4 ", "orderStatus": "out_for_delivery", "productName": "263", "totalAmount": "299.99"}	t	normal	2025-09-25 18:37:31.583974	2025-09-25 18:37:44.063
77	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated 📦	Your order has been delivered for products: 263.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 21, "memberName": "test mem 4 ", "orderStatus": "delivered", "productName": "263", "totalAmount": "299.99"}	t	normal	2025-09-25 18:55:06.266975	2025-09-25 18:55:14.225
79	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated ✅	Your order has been completed for products: 263.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 21, "memberName": "test mem 4 ", "orderStatus": "completed", "productName": "263", "totalAmount": "299.99"}	t	normal	2025-09-25 18:57:18.94426	2025-09-25 18:57:25.473
60	sample-seller-123	new_order	New Order Received! 🛒	You have received a new order for products: ak masala dosa, Premium Coffee Beans Selection. Order total: $76.97	{"orderId": 14, "sellerId": "sample-seller-123", "orderType": "group", "sellerName": "John Seller", "productName": "ak masala dosa, Premium Coffee Beans Selection", "totalAmount": "76.97"}	f	high	2025-09-24 08:14:51.666468	\N
65	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "9f8ae30e-aa65-4536-81ab-a2bc249b55fa", "groupId": 94, "orderId": 17, "groupName": "test group with notification", "memberName": "test mem 2 ", "productName": "354, 259", "totalAmount": "76.97"}	f	normal	2025-09-24 10:31:06.95139	\N
68	sample-seller-123	new_order	New Order Received! 🛒	You have received a new order for products: ak masala dosa, Premium Coffee Beans Selection. Order total: $76.97	{"orderId": 17, "sellerId": "sample-seller-123", "orderType": "group", "sellerName": "John Seller", "productName": "ak masala dosa, Premium Coffee Beans Selection", "totalAmount": "76.97"}	f	high	2025-09-24 10:31:08.999319	\N
64	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "groupId": 94, "orderId": 17, "groupName": "test group with notification", "memberName": "test mem 1 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 10:31:06.66771	2025-09-24 14:35:35.228
63	e053854f-e504-4ac4-9071-9ca5a309bcc4	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "e053854f-e504-4ac4-9071-9ca5a309bcc4", "groupId": 94, "orderId": 17, "groupName": "test group with notification", "memberName": "test owner 1 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 10:31:06.429756	2025-09-24 14:44:16.722
59	eb73e681-b4a4-489a-bfed-3669d774f217	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "orderId": 14, "groupName": "test group with notification", "memberName": "test mem 4 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 08:14:49.126297	2025-09-24 15:45:30.136
67	eb73e681-b4a4-489a-bfed-3669d774f217	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "groupId": 94, "orderId": 17, "groupName": "test group with notification", "memberName": "test mem 4 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 10:31:07.418528	2025-09-24 15:45:30.136
69	e053854f-e504-4ac4-9071-9ca5a309bcc4	payment_received	Payment Received	Payment of $4.56 received for: OneAnt (Order #18)	{"amount": 4.56, "orderId": 18, "productIds": [null]}	t	high	2025-09-24 15:51:07.164562	2025-09-24 15:51:50.913
70	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated ✅	Your order has been completed for products: 363.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 18, "memberName": "test mem 4 ", "orderStatus": "completed", "productName": "363", "totalAmount": "28.52"}	t	normal	2025-09-25 05:12:25.70238	2025-09-25 08:50:10.67
71	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated ✅	Your order has been completed for products: 363.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 18, "memberName": "test mem 4 ", "orderStatus": "completed", "productName": "363", "totalAmount": "28.52"}	t	normal	2025-09-25 05:12:31.493513	2025-09-25 08:50:10.67
72	e053854f-e504-4ac4-9071-9ca5a309bcc4	payment_received	Payment Received	Payment of $4.56 received for: OneAnt (Order #19)	{"amount": 4.56, "orderId": 19, "productIds": [null]}	t	high	2025-09-25 17:56:38.801145	2025-09-25 18:01:46.689
31	john-seller-456	group_owner_reminder	Complete Your Groups for Discounts! 🎯	You have 1 group that need more members to unlock discounts:\n\n"Home Comfort Collection" (0/5 members) - needs 5 more\n\nShare your groups with friends or promote them to reach the 5-member threshold and activate group discounts!	{"groups": [{"id": 86, "name": "Home Comfort Collection", "neededMembers": 5, "currentMembers": "0"}], "userId": "john-seller-456", "incompleteGroupsCount": 1}	t	normal	2025-09-22 08:40:02.640204	2025-09-25 18:34:55.636
61	john-seller-456	new_order	New Order Received	You have received a new order for "4K Ultra HD Smart TV" (Order #15)	{"orderId": 15, "productId": 263}	t	normal	2025-09-24 09:09:25.009671	2025-09-25 18:34:55.636
62	john-seller-456	payment_received	Payment Received	Payment of $599.98 received for: 4K Ultra HD Smart TV (Order #16)	{"amount": 599.98, "orderId": 16, "productIds": [null]}	t	high	2025-09-24 10:28:03.034057	2025-09-25 18:34:55.636
73	john-seller-456	payment_received	Payment Received	Payment of $249.99 received for: Adjustable Dumbbell Set (Order #20)	{"amount": 249.99, "orderId": 20, "productIds": [null]}	t	high	2025-09-25 18:12:39.801078	2025-09-25 18:34:55.636
75	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated 🔄	Your order is being prepared for products: 263.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 21, "memberName": "test mem 4 ", "orderStatus": "processing", "productName": "263", "totalAmount": "299.99"}	t	normal	2025-09-25 18:35:17.111088	2025-09-25 18:35:58.936
58	cd5c961e-620d-4952-afdf-9bb6c7abe26c	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "orderId": 14, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 08:14:48.882666	2025-09-27 09:01:53.331
78	eb73e681-b4a4-489a-bfed-3669d774f217	order_status_change	Order Status Updated ✅	Your order has been completed for products: 263.	{"userId": "eb73e681-b4a4-489a-bfed-3669d774f217", "orderId": 21, "memberName": "test mem 4 ", "orderStatus": "completed", "productName": "263", "totalAmount": "299.99"}	t	normal	2025-09-25 18:57:09.99016	2025-09-25 18:57:25.473
52	cd5c961e-620d-4952-afdf-9bb6c7abe26c	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "orderId": 13, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "354, 259", "totalAmount": "40.98"}	t	normal	2025-09-23 15:02:27.466319	2025-09-27 09:01:53.331
66	cd5c961e-620d-4952-afdf-9bb6c7abe26c	order_created	Order Created! 📦	An order has been created for your group "test group with notification" with products: 354, 259. Payment has been completed successfully.	{"userId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "groupId": 94, "orderId": 17, "groupName": "test group with notification", "memberName": "tem mem 3 ", "productName": "354, 259", "totalAmount": "76.97"}	t	normal	2025-09-24 10:31:07.185051	2025-09-27 09:01:53.331
83	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_status_change	Order Status Updated 🔄	Your order is being prepared for products: 367.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "orderId": 22, "memberName": "test mem 1 ", "orderStatus": "processing", "productName": "367", "totalAmount": "60.00"}	f	normal	2025-09-28 13:01:09.348795	\N
84	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_status_change	Order Status Updated 🚛	Your order is out for delivery for products: 367.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "orderId": 22, "memberName": "test mem 1 ", "orderStatus": "out_for_delivery", "productName": "367", "totalAmount": "60.00"}	f	normal	2025-09-28 13:01:30.151722	\N
82	c4eae527-82a6-47b4-bdbb-41f346a5073c	payment_received	Payment Received	Payment of $60.00 received for: Test Pet Training Service (Order #22)	{"amount": 60, "orderId": 22, "productIds": [null]}	t	high	2025-09-28 12:58:04.216793	2025-09-28 13:01:32.594
85	64e7c3c0-f155-4739-92da-5dc209d9ee40	order_status_change	Order Status Updated ✅	Your order has been completed for products: 367.	{"userId": "64e7c3c0-f155-4739-92da-5dc209d9ee40", "orderId": 22, "memberName": "test mem 1 ", "orderStatus": "completed", "productName": "367", "totalAmount": "60.00"}	f	normal	2025-09-28 13:03:43.17983	\N
86	cd5c961e-620d-4952-afdf-9bb6c7abe26c	group_join_request	New Join Request	test user t1 wants to join your group "test asd" for 4K Ultra HD Smart TV.	{"userId": "079f8a23-c6f9-4aee-ab58-b8e13cad10b8", "groupId": 95, "groupName": "test asd", "memberName": "test user t1", "memberEmail": null, "productName": "4K Ultra HD Smart TV"}	t	normal	2025-09-28 15:23:18.145532	2025-09-28 15:23:43.108
87	079f8a23-c6f9-4aee-ab58-b8e13cad10b8	request_accepted	Request Accepted! 🎉	Your request to join group "test asd" for 4K Ultra HD Smart TV has been accepted by the group owner.	{"userId": "079f8a23-c6f9-4aee-ab58-b8e13cad10b8", "groupId": 95, "groupName": "test asd", "memberName": "test user t1", "productName": "4K Ultra HD Smart TV"}	t	normal	2025-09-28 15:25:10.817459	2025-09-28 16:02:46.926
88	sample-seller-123	payment_received	Payment Received	Payment of $23.99 received for: bounty kitchen towel 16 pck (Order #23)	{"amount": 23.99, "orderId": 23, "productIds": [null]}	f	high	2025-09-28 18:54:11.453097	\N
89	john-seller-456	payment_received	Payment Received	Payment of $299.99 received for: 4K Ultra HD Smart TV (Order #24)	{"amount": 299.99, "orderId": 24, "productIds": [null]}	f	high	2025-10-07 18:08:33.104814	\N
\.


--
-- Data for Name: service_provider_staff; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.service_provider_staff (id, service_provider_id, name, skills, availability, rating, created_at) FROM stdin;
\.


--
-- Data for Name: service_providers; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.service_providers (id, product_id, legal_name, display_name, service_category, status, license_number, insurance_valid_till, years_in_business, service_mode, address_line_1, address_line_2, locality, region, postal_code, country, service_area_polygon, service_name, duration_minutes, pricing_model, materials_included, tax_class, age_restriction, availability_type, operating_hours, advance_booking_days, cancellation_policy_url, reschedule_allowed, avg_rating, review_count, highlighted_testimonials, insurance_policy_number, liability_waiver_required, health_safety_cert, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sessions (sid, sess, expire) FROM stdin;
yB-8nLgWjwZ30GfUV9rLd9orm1Ug9r24	{"user": {"id": "0ad8c455-0f61-4ec5-b043-ab333de54d34", "isSeller": false, "lastName": "", "firstName": "sandeep", "phoneNumber": "(555) 123-4567"}, "cookie": {"path": "/", "secure": false, "expires": "2025-10-14T17:37:22.986Z", "httpOnly": true, "originalMaxAge": 604800000}, "adminLogin": {"userId": "admin@123", "isAdmin": true}}	2025-10-14 18:21:34
gM_dhO1X11ZECKec0LNRsKwR-O0o7FSR	{"cookie": {"path": "/", "secure": false, "expires": "2025-10-07T16:28:38.342Z", "httpOnly": true, "originalMaxAge": 604800000}, "pendingAuth": {"otp": "5158", "createdAt": "2025-09-30T16:28:38.341Z", "phoneNumber": "(135) 555-5555", "sellerIntent": false}}	2025-10-08 08:25:17
XyRdh5o3Te3L8smY0aNkZdbzgpnB7X87	{"user": {"id": "80eaf7d6-ab44-40ce-8855-8a0660f65bba", "isSeller": false, "lastName": "", "firstName": "User", "phoneNumber": "(234) 564-2088"}, "cookie": {"path": "/", "secure": false, "expires": "2025-10-06T10:26:48.849Z", "httpOnly": true, "originalMaxAge": 604800000}}	2025-10-08 08:25:37
GZb6onb8xh1tha_3kvwankTQWoyVohp8	{"user": {"id": "cd5c961e-620d-4952-afdf-9bb6c7abe26c", "email": null, "storeId": null, "isSeller": false, "lastName": "", "firstName": "tem mem 3", "phoneNumber": "(546) 546-5465"}, "cookie": {"path": "/", "secure": false, "expires": "2025-10-08T16:10:26.178Z", "httpOnly": true, "originalMaxAge": 604800000}, "adminLogin": {"userId": "viswa968@gmail.com", "password": "QW@#er1234"}, "adminImpersonation": {"token": "20a0bca291ded3c958f5890f05115c47b7ade274384e6eea1d2b90f827133fbc", "adminUserId": "admin@123", "impersonatedUserId": "cd5c961e-620d-4952-afdf-9bb6c7abe26c"}, "impersonationTokens": {}}	2025-10-08 16:12:20
\.


--
-- Data for Name: subcategories; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.subcategories (id, category_id, name, slug, created_at) FROM stdin;
\.


--
-- Data for Name: user_addresses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_addresses (id, user_id, nickname, full_name, phone_number, address_line, city, pincode, state, country, is_default, created_at, updated_at) FROM stdin;
7	e053854f-e504-4ac4-9071-9ca5a309bcc4	test	test aa	(122) 123-1231	1 Infinite Loop	Cupertino	95014	CA	United States	f	2025-09-23 15:01:44.010296	2025-09-23 15:01:44.010296
5	e053854f-e504-4ac4-9071-9ca5a309bcc4	akjsdhk	ajkhsd	65465454584	665 Clyde Ave, Mountain View, CA 94043	 Mountain View	94043	CA	United States	f	2025-09-22 06:22:20.43512	2025-09-23 15:43:36.631
9	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	test	ausd	(122) 123-1231	1600 Amphitheatre Parkway, Mountain View, CA 94043	 Mountain View	94043	CA	United States	f	2025-09-24 07:07:32.648109	2025-09-24 07:07:32.648109
10	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	ssss	ausd	(122) 123-1231	665 Clyde Ave	 Mountain View	94043	CA	United States	t	2025-09-24 07:07:41.431795	2025-09-24 07:08:10.142
8	f7b75ec1-b027-4e4e-9a93-47367a3f86a7	test 1	ausd	(122) 123-1231	1600 Amphitheatre Parkway	 Mountain View	94043	CA	United States	f	2025-09-24 07:06:12.459668	2025-09-24 07:09:33.495
11	64e7c3c0-f155-4739-92da-5dc209d9ee40	test 1	ausd	(122) 123-1231	665 Clyde Ave	 Mountain View	94014	CA	United States	f	2025-09-24 08:03:53.826959	2025-09-24 08:13:40.032
6	eb73e681-b4a4-489a-bfed-3669d774f217	iuhuih	fggdt	645455htg	1234 Main Street	 Vancouver	V6B 3K9	British Columbia	United States	f	2025-09-22 06:28:45.37546	2025-09-25 16:51:40.584
12	eb73e681-b4a4-489a-bfed-3669d774f217	iuhuih	fggdt	645455htg	jhggjhugjhug	531515	tfdthgf	tgfhtgfv	United States	f	2025-09-25 16:52:06.692089	2025-09-25 16:52:06.692089
13	64e7c3c0-f155-4739-92da-5dc209d9ee40	Home	John Doe	(123) 456-7890	123 Main St, Apt 4B, Downtown, Vancouver	Vancouver	V6B 1A1	British Columbia	Canada	f	2025-09-28 12:57:04.416111	2025-09-28 12:57:04.416111
14	079f8a23-c6f9-4aee-ab58-b8e13cad10b8	test	ausd	(122) 123-1231	123 Main Street	Surrey	V6C 1T4	British Columbia	Canada	f	2025-09-28 18:13:55.41538	2025-09-28 18:15:28.563
15	cd5c961e-620d-4952-afdf-9bb6c7abe26c	test 1	test aa	(122) 123-1231	3735 Capilano Road	North Vancouver	V7R 4J1	BC	Canada	f	2025-09-28 20:03:29.57859	2025-09-28 20:03:29.57859
16	e053854f-e504-4ac4-9071-9ca5a309bcc4	Home	Bob Chan	(123) 234-5155	1234 Burrard Street	Vancouver	V6Z 2E8	British Columbia	Canada	f	2025-09-29 18:41:59.453654	2025-09-29 18:41:59.453654
17	0ad8c455-0f61-4ec5-b043-ab333de54d34	home	ajkhsd	(555) 456-7890	jsdjfklj	Burnaby	V5J 5K7	BC	Canada	f	2025-10-07 17:41:43.884217	2025-10-07 17:52:24.56
\.


--
-- Data for Name: user_group_items; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_group_items (id, user_group_id, product_id, quantity, added_at) FROM stdin;
212	85	257	1	2025-09-19 16:44:00.64789
213	85	258	1	2025-09-19 16:44:00.64789
214	85	259	1	2025-09-19 16:44:00.64789
215	86	260	1	2025-09-19 16:44:00.64789
216	86	261	1	2025-09-19 16:44:00.64789
217	86	262	1	2025-09-19 16:44:00.64789
218	87	263	1	2025-09-19 16:44:00.64789
219	87	264	1	2025-09-19 16:44:00.64789
220	87	265	1	2025-09-19 16:44:00.64789
221	88	266	1	2025-09-19 16:44:00.64789
222	88	267	1	2025-09-19 16:44:00.64789
223	88	268	1	2025-09-19 16:44:00.64789
224	89	269	1	2025-09-19 16:44:00.64789
225	89	270	1	2025-09-19 16:44:00.64789
226	89	271	1	2025-09-19 16:44:00.64789
227	90	272	1	2025-09-19 16:44:00.64789
228	90	273	1	2025-09-19 16:44:00.64789
229	90	274	1	2025-09-19 16:44:00.64789
230	91	275	1	2025-09-19 16:44:00.64789
231	91	276	1	2025-09-19 16:44:00.64789
232	91	277	1	2025-09-19 16:44:00.64789
233	92	278	1	2025-09-19 16:44:00.64789
234	92	279	1	2025-09-19 16:44:00.64789
235	92	280	1	2025-09-19 16:44:00.64789
236	93	281	1	2025-09-19 16:44:00.64789
237	93	282	1	2025-09-19 16:44:00.64789
238	94	354	1	2025-09-22 05:55:12.464304
239	94	259	2	2025-09-22 05:55:44.73015
240	95	263	1	2025-09-28 15:20:11.211329
241	96	455	2	2025-10-07 18:20:24.479386
\.


--
-- Data for Name: user_group_participants; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_group_participants (id, user_group_id, user_id, joined_at, status) FROM stdin;
373	85	sample-seller-123	2025-09-19 16:44:00.962305	pending
374	85	buyer-5	2025-09-19 16:44:00.962305	pending
375	85	buyer-4	2025-09-19 16:44:00.962305	pending
376	85	buyer-8	2025-09-19 16:44:00.962305	pending
377	85	buyer-14	2025-09-19 16:44:00.962305	pending
378	86	john-seller-456	2025-09-19 16:44:00.962305	pending
379	86	buyer-15	2025-09-19 16:44:00.962305	pending
380	86	buyer-8	2025-09-19 16:44:00.962305	pending
381	86	buyer-2	2025-09-19 16:44:00.962305	pending
382	86	sample-seller-123	2025-09-19 16:44:00.962305	pending
383	87	buyer-1	2025-09-19 16:44:00.962305	pending
384	87	buyer-11	2025-09-19 16:44:00.962305	pending
385	87	buyer-7	2025-09-19 16:44:00.962305	pending
386	87	buyer-12	2025-09-19 16:44:00.962305	pending
387	87	buyer-4	2025-09-19 16:44:00.962305	pending
388	88	buyer-2	2025-09-19 16:44:00.962305	pending
389	88	sample-seller-123	2025-09-19 16:44:00.962305	pending
390	88	john-seller-456	2025-09-19 16:44:00.962305	pending
391	88	buyer-5	2025-09-19 16:44:00.962305	pending
392	88	buyer-15	2025-09-19 16:44:00.962305	pending
393	89	buyer-3	2025-09-19 16:44:00.962305	pending
394	89	buyer-1	2025-09-19 16:44:00.962305	pending
395	89	buyer-10	2025-09-19 16:44:00.962305	pending
396	89	john-seller-456	2025-09-19 16:44:00.962305	pending
397	89	buyer-11	2025-09-19 16:44:00.962305	pending
398	90	buyer-4	2025-09-19 16:44:00.962305	pending
399	90	buyer-7	2025-09-19 16:44:00.962305	pending
400	90	buyer-1	2025-09-19 16:44:00.962305	pending
401	90	buyer-15	2025-09-19 16:44:00.962305	pending
402	90	buyer-9	2025-09-19 16:44:00.962305	pending
403	91	buyer-5	2025-09-19 16:44:00.962305	pending
404	91	buyer-3	2025-09-19 16:44:00.962305	pending
405	91	buyer-14	2025-09-19 16:44:00.962305	pending
406	91	buyer-6	2025-09-19 16:44:00.962305	pending
407	91	buyer-1	2025-09-19 16:44:00.962305	pending
408	92	buyer-6	2025-09-19 16:44:00.962305	pending
409	92	buyer-7	2025-09-19 16:44:00.962305	pending
410	92	buyer-2	2025-09-19 16:44:00.962305	pending
411	92	buyer-11	2025-09-19 16:44:00.962305	pending
412	92	buyer-9	2025-09-19 16:44:00.962305	pending
413	93	buyer-7	2025-09-19 16:44:00.962305	pending
414	93	sample-seller-123	2025-09-19 16:44:00.962305	pending
415	93	john-seller-456	2025-09-19 16:44:00.962305	pending
416	93	buyer-2	2025-09-19 16:44:00.962305	pending
417	93	buyer-9	2025-09-19 16:44:00.962305	pending
418	94	e053854f-e504-4ac4-9071-9ca5a309bcc4	2025-09-22 05:55:12.999539	approved
419	94	64e7c3c0-f155-4739-92da-5dc209d9ee40	2025-09-22 05:58:53.740209	approved
420	94	9f8ae30e-aa65-4536-81ab-a2bc249b55fa	2025-09-22 06:10:33.867055	approved
421	94	cd5c961e-620d-4952-afdf-9bb6c7abe26c	2025-09-22 06:14:22.378663	approved
422	94	eb73e681-b4a4-489a-bfed-3669d774f217	2025-09-22 06:16:48.575325	approved
423	95	cd5c961e-620d-4952-afdf-9bb6c7abe26c	2025-09-28 15:20:11.957926	approved
424	95	079f8a23-c6f9-4aee-ab58-b8e13cad10b8	2025-09-28 15:23:16.308162	approved
425	96	0ad8c455-0f61-4ec5-b043-ab333de54d34	2025-10-07 18:20:25.05825	approved
\.


--
-- Data for Name: user_groups; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.user_groups (id, user_id, name, description, share_token, is_public, created_at, updated_at, max_members, delivery_method, pickup_address_id) FROM stdin;
85	sample-seller-123	Tech Essentials Bundle	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	rL2xMwJkZlVFPQ6Ltz7NQtXp8H2cy_wu	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
86	john-seller-456	Home Comfort Collection	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	qZjEMjgEvxI8IZKxjpuf05fDxbbjxteC	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
87	buyer-1	Fitness & Wellness Pack	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	vhuIZCtcFj1By08SCTEdAF0N--IUUrnW	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
88	buyer-2	Fashion Forward Set	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	WsQpoH36kX8ftr7tCA0faQF8TomS9vRy	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
89	buyer-3	Smart Living Bundle	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	avsHPusFPuRnE47JRjcEte42H1HDGIUn	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
90	buyer-4	Gaming & Entertainment	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	79L4iL33IXLCt7DFl1rjmdMc-QxqhswO	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
91	buyer-5	Health & Beauty Kit	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	x4nsd1NEdUogS9qPe616Mrt8j1ezG9zl	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
92	buyer-6	Kitchen & Dining Set	Curated bundle featuring 3 amazing products at discounted prices when 5+ people join!	42FX9C3oU9pggOpLVROS8IMTJBpWp1cN	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
93	buyer-7	Outdoor Adventure Pack	Curated bundle featuring 2 amazing products at discounted prices when 5+ people join!	q40gJUjRt_jG6BldNbnd3oH6Bnwj8uEo	t	2025-09-19 16:44:00.311314	2025-09-19 16:44:00.311314	5	delivery	\N
95	cd5c961e-620d-4952-afdf-9bb6c7abe26c	test asd	A curated collection of 1 items for group buying	krqm19c4aphtg53y5qppq	t	2025-09-28 15:20:10.914593	2025-09-28 15:20:10.914593	5	delivery	\N
94	e053854f-e504-4ac4-9071-9ca5a309bcc4	test group with notification	A curated collection of 1 items for group buying	4mdj6wt30mg5pqywjr8ym7	t	2025-09-22 05:55:12.19345	2025-09-29 18:42:04.786	5	pickup	\N
96	0ad8c455-0f61-4ec5-b043-ab333de54d34	Ghee Group	A curated collection of 1 items for group buying	9a127yk60mdckp8yir1886	t	2025-10-07 18:20:24.194173	2025-10-07 18:20:24.194173	5	delivery	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, first_name, last_name, profile_image_url, is_seller, created_at, updated_at, phone_number, store_id, shop_type, legal_name, display_name, status, address_line_1, address_line_2, locality, region, postal_code, country, timezone, operating_hours, currency, languages, substitution_policy, age_check_enabled, refund_policy_url, service_area_polygon, pickup_hours, delivery_hours, delivery_fee, free_delivery_threshold, minimum_order_value, delivery_radius_km, delivery_fee_per_km) FROM stdin;
cd67e11c-dfb5-4bea-ba77-c54aab7c1a5c	\N	User		\N	f	2025-09-19 09:54:43.936437	2025-09-19 09:54:43.936437	+1234567890	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
ba561902-dde6-4464-8bbb-c9cf0fa0f974	\N	User		\N	f	2025-09-19 10:02:26.429404	2025-09-19 10:02:26.429404	(445) 345-4546	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
6c57dfa6-9b0e-4eae-a3ab-3dfe49baf817	\N	User		\N	f	2025-09-19 10:05:19.13801	2025-09-19 10:05:19.13801	(545) 465-6146	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
a3cc0de3-64ae-423b-871e-947b5d994969	\N	User		\N	f	2025-09-19 10:14:19.284896	2025-09-19 10:14:19.284896	(564) 668-8484	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
53635adb-cab9-40b6-8ac2-fd4de18d8bf6	\N	User		\N	f	2025-09-19 15:50:04.438773	2025-09-19 15:50:04.438773	(484) 465-4646	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
dc4e9f57-9bd2-489f-b8c7-8be270f6a00f	\N	User		\N	f	2025-09-19 15:52:33.335726	2025-09-19 15:52:33.335726	(646) 446-4654	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-1	buyer1@oneant.com	Buyer	1	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-2	buyer2@oneant.com	Buyer	2	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-3	buyer3@oneant.com	Buyer	3	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-4	buyer4@oneant.com	Buyer	4	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-5	buyer5@oneant.com	Buyer	5	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-6	buyer6@oneant.com	Buyer	6	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-7	buyer7@oneant.com	Buyer	7	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-8	buyer8@oneant.com	Buyer	8	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-9	buyer9@oneant.com	Buyer	9	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-10	buyer10@oneant.com	Buyer	10	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-11	buyer11@oneant.com	Buyer	11	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-12	buyer12@oneant.com	Buyer	12	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-13	buyer13@oneant.com	Buyer	13	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-14	buyer14@oneant.com	Buyer	14	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
buyer-15	buyer15@oneant.com	Buyer	15	\N	f	2025-09-19 16:44:00.038755	2025-09-19 16:44:00.038755	\N	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
ef4e71c6-69e6-4145-951c-463c963977ae	\N	user 		\N	f	2025-09-19 10:10:14.7247	2025-09-19 10:10:14.7247	(564) 555-5545	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
64e7c3c0-f155-4739-92da-5dc209d9ee40	\N	test mem 1		\N	f	2025-09-22 05:58:38.59598	2025-09-22 05:58:38.59598	(546) 544-6564	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
9f8ae30e-aa65-4536-81ab-a2bc249b55fa	\N	test mem 2		\N	f	2025-09-22 06:10:27.208392	2025-09-22 06:10:27.208392	(555) 555-5456	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
cd5c961e-620d-4952-afdf-9bb6c7abe26c	\N	tem mem 3		\N	f	2025-09-22 06:14:13.24212	2025-09-22 06:14:13.24212	(546) 546-5465	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
80eaf7d6-ab44-40ce-8855-8a0660f65bba	\N	User		\N	f	2025-09-29 10:26:50.464565	2025-09-29 10:26:50.464565	(234) 564-2088	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
cdf368f7-5051-48aa-b938-a9f0b09d9cd1	\N	User		\N	t	2025-09-29 15:57:03.824381	2025-09-29 15:57:03.824381	(155) 456-5543	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
f8285310-1f11-4550-a062-92d1ad950ead	\N	User		\N	t	2025-09-23 14:48:54.685648	2025-09-24 05:24:39.955	(151) 515-5151	testtqw	services	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
9bc9fd60-6b6c-44ad-8af8-299f3e172557	\N	User		\N	f	2025-09-24 06:52:40.72157	2025-09-24 06:52:40.72157	(564) 564-5645	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
eb73e681-b4a4-489a-bfed-3669d774f217	\N	test mem 4		\N	t	2025-09-22 06:16:18.758048	2025-09-26 08:39:36.165	(555) 774-7474	frestmart 2	groceries	frestmart 2	frestmart 2	active	3735 Capilano Road	\N	North Vancouver	BC	V7R 4J1	CA	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
15de9011-c8d3-472e-9d2b-976d36d79c67	\N			\N	t	2025-09-27 04:37:36.678936	2025-09-27 04:37:36.589		ST0023	services	gobal service 2	gobal service 2	active	123 Main Street	\N	Surrey	BC	V6C 1T4	CA	\N	\N	CAD	en	customer_opt_in	f	\N	\N	\N	\N	0.00	0.00	0.00	10	3.99
c4eae527-82a6-47b4-bdbb-41f346a5073c	\N	User		\N	t	2025-09-27 13:59:21.594006	2025-09-28 06:32:42.419	(135) 151-5145	pet 	pet-essentials	pet	pet cr	active	500 Granville Street	\N	Vancouver	BC	V6C 1W6	CA	\N	\N	CAD	en	customer_opt_in	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.98
45fb235c-aff4-406d-9e34-8343ff5b216b	\N	User		\N	f	2025-09-25 17:53:26.868907	2025-09-25 17:53:26.868907	1234567890	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
f7b75ec1-b027-4e4e-9a93-47367a3f86a7	\N	User		\N	t	2025-09-24 05:19:27.337935	2025-09-26 06:54:40.701	(555) 555-4785	test	services	asd	dsa	active	2329 West Mall	\N	Vancouver	BC	V6T 1Z4	CA	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	100.36	0.00	0.00	10	5.84
e053854f-e504-4ac4-9071-9ca5a309bcc4	\N	test owner 1	frestmart 1	\N	t	2025-09-22 05:42:36.084044	2025-09-26 05:37:07.089	(561) 551-5156	frestmart 1	groceries	frestmart 1	frestmart 1	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.86
4971fb96-7269-4774-8bb8-14550cd031dd	\N	User		\N	f	2025-09-28 14:34:30.997292	2025-09-28 14:34:30.997292	5551234567	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
48d7c0f4-1713-4da0-a597-7f687adfe529	\N	User		\N	f	2025-09-29 16:14:18.586148	2025-09-29 16:14:18.586148	(534) 545-6665	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
079f8a23-c6f9-4aee-ab58-b8e13cad10b8	\N	test	user t1	\N	f	2025-09-19 09:41:23.871129	2025-09-19 09:41:23.871129	(545) 464-6844	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	0.00
e3d33e5b-be09-49ea-b081-d68cfba5a288	\N	User		\N	f	2025-09-28 19:09:38.442198	2025-09-28 19:09:38.442198	(554) 655-6454	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
sample-seller-123	seller@oneant.com	John	Seller	\N	t	2025-09-19 09:53:41.520788	2025-09-26 05:20:43.588	(111) 121-2122	\N	groceries	\N	\N	active	5678 Douglas Street	\N	Victoria	British Columbia	V8W 2B7	United States	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	1.99
35d90dda-932b-45c2-a7f9-9474d43ad04f	\N	User		\N	f	2025-09-30 16:29:51.956021	2025-09-30 16:29:51.956021	(222) 222-2222	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
john-seller-456	john@oneant.com	John	Smith	\N	t	2025-09-19 09:53:41.826104	2025-09-25 18:14:43.311	(222) 233-2333	John Smith	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	4.99
fc4b152b-55e9-45c3-8baf-32980810f96d	\N	User		\N	t	2025-09-27 14:00:07.704953	2025-09-27 14:00:24.677	(615) 465-4564	User	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	4.99
0ad8c455-0f61-4ec5-b043-ab333de54d34	\N	sandeep		\N	f	2025-10-07 17:37:22.948648	2025-10-07 17:37:22.948648	(555) 123-4567	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
846cd9ee-9eca-4928-bc2e-fe6bd1d6c2c0	\N	Test	User2	\N	f	2025-10-01 05:13:04.755652	2025-10-01 05:13:04.755652	1234567891	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
34f101c7-cc97-48e8-b36f-300c0f634cfe	\N	Test	User3	\N	f	2025-10-01 05:13:04.755652	2025-10-01 05:13:04.755652	1234567892	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
2b44af04-8e2d-4d87-9417-d953389b2fe8	\N	Test	User4	\N	f	2025-10-01 05:13:04.755652	2025-10-01 05:13:04.755652	1234567893	\N	groceries	\N	\N	active	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	0.00	0.00	0.00	10	5.99
\.


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: neondb_owner
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 1, false);


--
-- Name: admin_credentials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.admin_credentials_id_seq', 5, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 72, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.categories_id_seq', 170, true);


--
-- Name: discount_tiers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.discount_tiers_id_seq', 947, true);


--
-- Name: feedback_submissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.feedback_submissions_id_seq', 1, false);


--
-- Name: grocery_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.grocery_products_id_seq', 204, true);


--
-- Name: group_payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.group_payments_id_seq', 86, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.order_items_id_seq', 27, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.orders_id_seq', 24, true);


--
-- Name: pet_provider_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.pet_provider_staff_id_seq', 1, false);


--
-- Name: pet_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.pet_providers_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.products_id_seq', 487, true);


--
-- Name: seller_inquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.seller_inquiries_id_seq', 1, false);


--
-- Name: seller_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.seller_notifications_id_seq', 89, true);


--
-- Name: service_provider_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.service_provider_staff_id_seq', 1, false);


--
-- Name: service_providers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.service_providers_id_seq', 1, false);


--
-- Name: subcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.subcategories_id_seq', 1, false);


--
-- Name: user_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_addresses_id_seq', 17, true);


--
-- Name: user_group_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_group_items_id_seq', 241, true);


--
-- Name: user_group_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_group_participants_id_seq', 425, true);


--
-- Name: user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.user_groups_id_seq', 96, true);


--
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- Name: admin_credentials admin_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_credentials
    ADD CONSTRAINT admin_credentials_pkey PRIMARY KEY (id);


--
-- Name: admin_credentials admin_credentials_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.admin_credentials
    ADD CONSTRAINT admin_credentials_user_id_unique UNIQUE (user_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: discount_tiers discount_tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.discount_tiers
    ADD CONSTRAINT discount_tiers_pkey PRIMARY KEY (id);


--
-- Name: feedback_submissions feedback_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feedback_submissions
    ADD CONSTRAINT feedback_submissions_pkey PRIMARY KEY (id);


--
-- Name: grocery_products grocery_products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.grocery_products
    ADD CONSTRAINT grocery_products_pkey PRIMARY KEY (id);


--
-- Name: grocery_products grocery_products_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.grocery_products
    ADD CONSTRAINT grocery_products_product_id_unique UNIQUE (product_id);


--
-- Name: group_payments group_payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_pkey PRIMARY KEY (id);


--
-- Name: group_payments group_payments_stripe_payment_intent_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_stripe_payment_intent_id_unique UNIQUE (stripe_payment_intent_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pet_provider_staff pet_provider_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_provider_staff
    ADD CONSTRAINT pet_provider_staff_pkey PRIMARY KEY (id);


--
-- Name: pet_providers pet_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_providers
    ADD CONSTRAINT pet_providers_pkey PRIMARY KEY (id);


--
-- Name: pet_providers pet_providers_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_providers
    ADD CONSTRAINT pet_providers_product_id_unique UNIQUE (product_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: seller_inquiries seller_inquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.seller_inquiries
    ADD CONSTRAINT seller_inquiries_pkey PRIMARY KEY (id);


--
-- Name: seller_notifications seller_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.seller_notifications
    ADD CONSTRAINT seller_notifications_pkey PRIMARY KEY (id);


--
-- Name: service_provider_staff service_provider_staff_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_pkey PRIMARY KEY (id);


--
-- Name: service_providers service_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers
    ADD CONSTRAINT service_providers_pkey PRIMARY KEY (id);


--
-- Name: service_providers service_providers_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers
    ADD CONSTRAINT service_providers_product_id_unique UNIQUE (product_id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: subcategories subcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_pkey PRIMARY KEY (id);


--
-- Name: user_addresses user_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_addresses
    ADD CONSTRAINT user_addresses_pkey PRIMARY KEY (id);


--
-- Name: user_group_items user_group_items_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_items
    ADD CONSTRAINT user_group_items_pkey PRIMARY KEY (id);


--
-- Name: user_group_participants user_group_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_participants
    ADD CONSTRAINT user_group_participants_pkey PRIMARY KEY (id);


--
-- Name: user_groups user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_groups user_groups_share_token_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_share_token_unique UNIQUE (share_token);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_phone_number_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_number_unique UNIQUE (phone_number);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_store_id_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_store_id_unique UNIQUE (store_id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- Name: cart_items cart_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: cart_items cart_items_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: discount_tiers discount_tiers_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.discount_tiers
    ADD CONSTRAINT discount_tiers_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: feedback_submissions feedback_submissions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.feedback_submissions
    ADD CONSTRAINT feedback_submissions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: grocery_products grocery_products_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.grocery_products
    ADD CONSTRAINT grocery_products_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: group_payments group_payments_payer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_payer_id_users_id_fk FOREIGN KEY (payer_id) REFERENCES public.users(id);


--
-- Name: group_payments group_payments_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: group_payments group_payments_user_group_id_user_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_user_group_id_user_groups_id_fk FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: group_payments group_payments_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.group_payments
    ADD CONSTRAINT group_payments_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: order_items order_items_order_id_orders_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_orders_id_fk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_address_id_user_addresses_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_address_id_user_addresses_id_fk FOREIGN KEY (address_id) REFERENCES public.user_addresses(id);


--
-- Name: orders orders_payer_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_payer_id_users_id_fk FOREIGN KEY (payer_id) REFERENCES public.users(id);


--
-- Name: orders orders_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_user_group_id_user_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_group_id_user_groups_id_fk FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: orders orders_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pet_provider_staff pet_provider_staff_pet_provider_id_pet_providers_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_provider_staff
    ADD CONSTRAINT pet_provider_staff_pet_provider_id_pet_providers_id_fk FOREIGN KEY (pet_provider_id) REFERENCES public.pet_providers(id);


--
-- Name: pet_providers pet_providers_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.pet_providers
    ADD CONSTRAINT pet_providers_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: products products_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: products products_seller_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_users_id_fk FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- Name: products products_subcategory_id_subcategories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_subcategory_id_subcategories_id_fk FOREIGN KEY (subcategory_id) REFERENCES public.subcategories(id);


--
-- Name: seller_notifications seller_notifications_seller_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.seller_notifications
    ADD CONSTRAINT seller_notifications_seller_id_users_id_fk FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- Name: service_provider_staff service_provider_staff_service_provider_id_service_providers_id; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_provider_staff
    ADD CONSTRAINT service_provider_staff_service_provider_id_service_providers_id FOREIGN KEY (service_provider_id) REFERENCES public.service_providers(id);


--
-- Name: service_providers service_providers_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers
    ADD CONSTRAINT service_providers_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: subcategories subcategories_category_id_categories_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.subcategories
    ADD CONSTRAINT subcategories_category_id_categories_id_fk FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: user_addresses user_addresses_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_addresses
    ADD CONSTRAINT user_addresses_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_group_items user_group_items_product_id_products_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_items
    ADD CONSTRAINT user_group_items_product_id_products_id_fk FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: user_group_items user_group_items_user_group_id_user_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_items
    ADD CONSTRAINT user_group_items_user_group_id_user_groups_id_fk FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: user_group_participants user_group_participants_user_group_id_user_groups_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_participants
    ADD CONSTRAINT user_group_participants_user_group_id_user_groups_id_fk FOREIGN KEY (user_group_id) REFERENCES public.user_groups(id);


--
-- Name: user_group_participants user_group_participants_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_group_participants
    ADD CONSTRAINT user_group_participants_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_groups user_groups_pickup_address_id_user_addresses_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_pickup_address_id_user_addresses_id_fk FOREIGN KEY (pickup_address_id) REFERENCES public.user_addresses(id);


--
-- Name: user_groups user_groups_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.user_groups
    ADD CONSTRAINT user_groups_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict NvhTGEFpfwAXrc4w4TSYKvxShC7msas01Y519U9sp4nFZ9MDidsUevda63qLbDb

