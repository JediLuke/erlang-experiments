/* mynif.c */
#include "erl_nif.h"

static ERL_NIF_TERM hello(ErlNifEnv* env, int argc, const ERL_NIF_TERM** argv)
{
    int ar; // length o a tuple
    unsigned long a,b,c,a1,b1,c1;
    const ERL_NIF_TERM** tuple;
        enif_get_ulong(env, argv[0], &a);
        enif_get_ulong(env, argv[1], &b);
        enif_get_tuple(env, argv[2], &ar, &tuple);
        c = a*b;
        enif_get_ulong(env, tuple[0], &a1);
        enif_get_ulong(env, tuple[1], &b1);
        c1 = a1*b1;

        return enif_make_tuple3(env, enif_make_ulong(env, ar), enif_make_ulong(env, c), enif_make_ulong(env, c));
}

static ErlNifFunc nif_funcs[] =
{
    {"hello", 3, hello}
};

ERL_NIF_INIT(mynif,nif_funcs,NULL,NULL,NULL,NULL)