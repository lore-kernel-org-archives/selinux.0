Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8519CC433F5
	for <selinux@archiver.kernel.org>; Tue, 23 Nov 2021 09:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhKWJq6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 04:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231240AbhKWJq6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 04:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637660630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8Eb5fRk57+Qvkv7jt96TUWzjuDTbnSjsALNzAvTfbGs=;
        b=XuJlfRHCf13B0pW5RQxnyjLZMtH194jRw/6wNZtjKFn2ihLlznRJk5t9D9dnBfT78VwzCU
        AyTBtafR8V6h0fiwR9iqXt/tSbRSM61JlVfJaKUtuYs7CL4Cr5xPS3JCNU9bW6s7Fpzc5J
        M5idV6uuIE+zWTE/AH0ne8l+m35Jsuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-y3sXcQ2oNk-WlEKYKOlowQ-1; Tue, 23 Nov 2021 04:43:48 -0500
X-MC-Unique: y3sXcQ2oNk-WlEKYKOlowQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EFFC871805;
        Tue, 23 Nov 2021 09:43:47 +0000 (UTC)
Received: from localhost (unknown [10.40.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 633DA19D9F;
        Tue, 23 Nov 2021 09:43:46 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [PATCH] semodule: add -m | --checksum option
In-Reply-To: <CAP+JOzT94U1kA7OrPYGebnzRm_vEg4MPnz4UBQxZN=TXrAtigQ@mail.gmail.com>
References: <20211116132711.163668-1-plautrba@redhat.com>
 <CAP+JOzT94U1kA7OrPYGebnzRm_vEg4MPnz4UBQxZN=TXrAtigQ@mail.gmail.com>
Date:   Tue, 23 Nov 2021 10:43:40 +0100
Message-ID: <87k0gzky0j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Nov 16, 2021 at 8:32 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Since cil doesn't store module name and module version in module itself,
>> there's no simple way how to compare that installed module is the same
>> version as the module which is supposed to be installed. Even though the
>> version was not used by semodule itself, it was apparently used by some
>> team.
>>
>> With `semodule -l --checksum` users get SHA256 hashes of modules and
>> could compare them with their files which is faster than installing
>> modules again and again.
>>
>> E.g.
>>
>>     # time (
>>     semodule -l --checksum | grep localmodule
>>     /usr/libexec/selinux/hll/pp localmodule.pp | sha256sum
>>     )
>>     localmodule db002f64ddfa3983257b42b54da7b182c9b2e476f47880ae3494f9099e1a42bd
>>     db002f64ddfa3983257b42b54da7b182c9b2e476f47880ae3494f9099e1a42bd  -
>>
>>     real    0m0.876s
>>     user    0m0.849s
>>     sys     0m0.028s
>>
>> vs
>>
>>     # time semodule -i localmodule.pp
>>
>>     real    0m6.147s
>>     user    0m5.800s
>>     sys     0m0.231s
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks.

It's merged now.

>
>
>> ---
>>  policycoreutils/semodule/Makefile   |   2 +-
>>  policycoreutils/semodule/semodule.8 |   6 +
>>  policycoreutils/semodule/semodule.c |  95 ++++++++-
>>  policycoreutils/semodule/sha256.c   | 294 ++++++++++++++++++++++++++++
>>  policycoreutils/semodule/sha256.h   |  89 +++++++++
>>  5 files changed, 480 insertions(+), 6 deletions(-)
>>  create mode 100644 policycoreutils/semodule/sha256.c
>>  create mode 100644 policycoreutils/semodule/sha256.h
>>
>> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
>> index 73801e487a76..9875ac383280 100644
>> --- a/policycoreutils/semodule/Makefile
>> +++ b/policycoreutils/semodule/Makefile
>> @@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
>>
>>  CFLAGS ?= -Werror -Wall -W
>>  override LDLIBS += -lsepol -lselinux -lsemanage
>> -SEMODULE_OBJS = semodule.o
>> +SEMODULE_OBJS = semodule.o sha256.o
>>
>>  all: semodule genhomedircon
>>
>> diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
>> index 18d4f708661c..3a2fb21c2481 100644
>> --- a/policycoreutils/semodule/semodule.8
>> +++ b/policycoreutils/semodule/semodule.8
>> @@ -95,6 +95,9 @@ only modules listed in \-\-extract after this option.
>>  .B  \-H,\-\-hll
>>  Extract module as an HLL file. This only affects the \-\-extract option and
>>  only modules listed in \-\-extract after this option.
>> +.TP
>> +.B  \-m,\-\-checksum
>> +Add SHA256 checksum of modules to the list output.
>>
>>  .SH EXAMPLE
>>  .nf
>> @@ -130,6 +133,9 @@ $ semodule \-B \-S "/tmp/var/lib/selinux"
>>  # Write the HLL version of puppet and the CIL version of wireshark
>>  # modules at priority 400 to the current working directory
>>  $ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
>> +# Check whether a module in "localmodule.pp" file is same as installed module "localmodule"
>> +$ /usr/libexec/selinux/hll/pp localmodule.pp | sha256sum
>> +$ semodule -l -m | grep localmodule
>>  .fi
>>
>>  .SH SEE ALSO
>> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
>> index c815f01546b4..ddbf10455abf 100644
>> --- a/policycoreutils/semodule/semodule.c
>> +++ b/policycoreutils/semodule/semodule.c
>> @@ -25,6 +25,8 @@
>>  #include <sepol/cil/cil.h>
>>  #include <semanage/modules.h>
>>
>> +#include "sha256.h"
>> +
>>  enum client_modes {
>>         NO_MODE, INSTALL_M, REMOVE_M, EXTRACT_M, CIL_M, HLL_M,
>>         LIST_M, RELOAD, PRIORITY_M, ENABLE_M, DISABLE_M
>> @@ -57,6 +59,7 @@ static semanage_handle_t *sh = NULL;
>>  static char *store;
>>  static char *store_root;
>>  int extract_cil = 0;
>> +static int checksum = 0;
>>
>>  extern char *optarg;
>>  extern int optind;
>> @@ -147,6 +150,7 @@ static void usage(char *progname)
>>         printf("  -S,--store-path  use an alternate path for the policy store root\n");
>>         printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
>>         printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
>> +       printf("  -m, --checksum   print module checksum (SHA256).\n");
>>  }
>>
>>  /* Sets the global mode variable to new_mode, but only if no other
>> @@ -200,6 +204,7 @@ static void parse_command_line(int argc, char **argv)
>>                 {"disable", required_argument, NULL, 'd'},
>>                 {"path", required_argument, NULL, 'p'},
>>                 {"store-path", required_argument, NULL, 'S'},
>> +               {"checksum", 0, NULL, 'm'},
>>                 {NULL, 0, NULL, 0}
>>         };
>>         int extract_selected = 0;
>> @@ -210,7 +215,7 @@ static void parse_command_line(int argc, char **argv)
>>         no_reload = 0;
>>         priority = 400;
>>         while ((i =
>> -               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
>> +               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm", opts,
>>                             NULL)) != -1) {
>>                 switch (i) {
>>                 case 'b':
>> @@ -287,6 +292,9 @@ static void parse_command_line(int argc, char **argv)
>>                 case 'd':
>>                         set_mode(DISABLE_M, optarg);
>>                         break;
>> +               case 'm':
>> +                       checksum = 1;
>> +                       break;
>>                 case '?':
>>                 default:{
>>                                 usage(argv[0]);
>> @@ -338,6 +346,61 @@ static void parse_command_line(int argc, char **argv)
>>         }
>>  }
>>
>> +/* Get module checksum */
>> +static char *hash_module_data(const char *module_name, const int prio) {
>> +       semanage_module_info_t *extract_info = NULL;
>> +       semanage_module_key_t *modkey = NULL;
>> +       Sha256Context context;
>> +       uint8_t sha256_hash[SHA256_HASH_SIZE];
>> +       char *sha256_buf = NULL;
>> +       void *data;
>> +       size_t data_len = 0, i;
>> +       int result;
>> +
>> +       result = semanage_module_key_create(sh, &modkey);
>> +       if (result != 0) {
>> +               goto cleanup_extract;
>> +       }
>> +
>> +       result = semanage_module_key_set_name(sh, modkey, module_name);
>> +       if (result != 0) {
>> +               goto cleanup_extract;
>> +       }
>> +
>> +       result = semanage_module_key_set_priority(sh, modkey, prio);
>> +       if (result != 0) {
>> +               goto cleanup_extract;
>> +       }
>> +
>> +       result = semanage_module_extract(sh, modkey, 1, &data, &data_len,
>> +                                                                        &extract_info);
>> +       if (result != 0) {
>> +               goto cleanup_extract;
>> +       }
>> +
>> +       Sha256Initialise(&context);
>> +       Sha256Update(&context, data, data_len);
>> +
>> +       Sha256Finalise(&context, (SHA256_HASH *)sha256_hash);
>> +
>> +       sha256_buf = calloc(1, SHA256_HASH_SIZE * 2 + 1);
>> +
>> +       if (sha256_buf == NULL)
>> +               goto cleanup_extract;
>> +
>> +       for (i = 0; i < SHA256_HASH_SIZE; i++) {
>> +               sprintf((&sha256_buf[i * 2]), "%02x", sha256_hash[i]);
>> +       }
>> +       sha256_buf[i * 2] = 0;
>> +
>> +cleanup_extract:
>> +       semanage_module_info_destroy(sh, extract_info);
>> +       free(extract_info);
>> +       semanage_module_key_destroy(sh, modkey);
>> +       free(modkey);
>> +       return sha256_buf;
>> +}
>> +
>>  int main(int argc, char *argv[])
>>  {
>>         int i, commit = 0;
>> @@ -546,6 +609,8 @@ cleanup_extract:
>>                                 int modinfos_len = 0;
>>                                 semanage_module_info_t *m = NULL;
>>                                 int j = 0;
>> +                               char *module_checksum = NULL;
>> +                               uint16_t pri = 0;
>>
>>                                 if (verbose) {
>>                                         printf
>> @@ -570,7 +635,18 @@ cleanup_extract:
>>                                                 result = semanage_module_info_get_name(sh, m, &name);
>>                                                 if (result != 0) goto cleanup_list;
>>
>> -                                               printf("%s\n", name);
>> +                                               result = semanage_module_info_get_priority(sh, m, &pri);
>> +                                               if (result != 0) goto cleanup_list;
>> +
>> +                                               printf("%s", name);
>> +                                               if (checksum) {
>> +                                                       module_checksum = hash_module_data(name, pri);
>> +                                                       if (module_checksum) {
>> +                                                               printf(" %s", module_checksum);
>> +                                                               free(module_checksum);
>> +                                                       }
>> +                                               }
>> +                                               printf("\n");
>>                                         }
>>                                 }
>>                                 else if (strcmp(mode_arg, "full") == 0) {
>> @@ -585,11 +661,12 @@ cleanup_extract:
>>                                         }
>>
>>                                         /* calculate column widths */
>> -                                       size_t column[4] = { 0, 0, 0, 0 };
>> +                                       size_t column[5] = { 0, 0, 0, 0, 0 };
>>
>>                                         /* fixed width columns */
>>                                         column[0] = sizeof("000") - 1;
>>                                         column[3] = sizeof("disabled") - 1;
>> +                                       column[4] = 64; /* SHA256_HASH_SIZE * 2 */
>>
>>                                         /* variable width columns */
>>                                         const char *tmp = NULL;
>> @@ -612,7 +689,6 @@ cleanup_extract:
>>
>>                                         /* print out each module */
>>                                         for (j = 0; j < modinfos_len; j++) {
>> -                                               uint16_t pri = 0;
>>                                                 const char *name = NULL;
>>                                                 int enabled = 0;
>>                                                 const char *lang_ext = NULL;
>> @@ -631,11 +707,20 @@ cleanup_extract:
>>                                                 result = semanage_module_info_get_lang_ext(sh, m, &lang_ext);
>>                                                 if (result != 0) goto cleanup_list;
>>
>> -                                               printf("%0*u %-*s %-*s %-*s\n",
>> +                                               printf("%0*u %-*s %-*s %-*s",
>>                                                         (int)column[0], pri,
>>                                                         (int)column[1], name,
>>                                                         (int)column[2], lang_ext,
>>                                                         (int)column[3], enabled ? "" : "disabled");
>> +                                               if (checksum) {
>> +                                                       module_checksum = hash_module_data(name, pri);
>> +                                                       if (module_checksum) {
>> +                                                               printf(" %-*s", (int)column[4], module_checksum);
>> +                                                               free(module_checksum);
>> +                                                       }
>> +                                               }
>> +                                               printf("\n");
>> +
>>                                         }
>>                                 }
>>                                 else {
>> diff --git a/policycoreutils/semodule/sha256.c b/policycoreutils/semodule/sha256.c
>> new file mode 100644
>> index 000000000000..fe2aeef07f53
>> --- /dev/null
>> +++ b/policycoreutils/semodule/sha256.c
>> @@ -0,0 +1,294 @@
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  WjCryptLib_Sha256
>> +//
>> +//  Implementation of SHA256 hash function.
>> +//  Original author: Tom St Denis, tomstdenis@gmail.com, http://libtom.org
>> +//  Modified by WaterJuice retaining Public Domain license.
>> +//
>> +//  This is free and unencumbered software released into the public domain - June 2013 waterjuice.org
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  IMPORTS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +#include "sha256.h"
>> +#include <memory.h>
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  MACROS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +#define ror(value, bits) (((value) >> (bits)) | ((value) << (32 - (bits))))
>> +
>> +#define MIN(x, y) ( ((x)<(y))?(x):(y) )
>> +
>> +#define STORE32H(x, y)                                                                     \
>> +     { (y)[0] = (uint8_t)(((x)>>24)&255); (y)[1] = (uint8_t)(((x)>>16)&255);   \
>> +       (y)[2] = (uint8_t)(((x)>>8)&255); (y)[3] = (uint8_t)((x)&255); }
>> +
>> +#define LOAD32H(x, y)                            \
>> +     { x = ((uint32_t)((y)[0] & 255)<<24) | \
>> +           ((uint32_t)((y)[1] & 255)<<16) | \
>> +           ((uint32_t)((y)[2] & 255)<<8)  | \
>> +           ((uint32_t)((y)[3] & 255)); }
>> +
>> +#define STORE64H(x, y)                                                                     \
>> +   { (y)[0] = (uint8_t)(((x)>>56)&255); (y)[1] = (uint8_t)(((x)>>48)&255);     \
>> +     (y)[2] = (uint8_t)(((x)>>40)&255); (y)[3] = (uint8_t)(((x)>>32)&255);     \
>> +     (y)[4] = (uint8_t)(((x)>>24)&255); (y)[5] = (uint8_t)(((x)>>16)&255);     \
>> +     (y)[6] = (uint8_t)(((x)>>8)&255); (y)[7] = (uint8_t)((x)&255); }
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  CONSTANTS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +// The K array
>> +static const uint32_t K[64] = {
>> +    0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
>> +    0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
>> +    0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
>> +    0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
>> +    0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
>> +    0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
>> +    0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
>> +    0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
>> +    0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
>> +    0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
>> +    0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
>> +    0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
>> +    0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
>> +};
>> +
>> +#define BLOCK_SIZE          64
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  INTERNAL FUNCTIONS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +// Various logical functions
>> +#define Ch( x, y, z )     (z ^ (x & (y ^ z)))
>> +#define Maj( x, y, z )    (((x | y) & z) | (x & y))
>> +#define S( x, n )         ror((x),(n))
>> +#define R( x, n )         (((x)&0xFFFFFFFFUL)>>(n))
>> +#define Sigma0( x )       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
>> +#define Sigma1( x )       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
>> +#define Gamma0( x )       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
>> +#define Gamma1( x )       (S(x, 17) ^ S(x, 19) ^ R(x, 10))
>> +
>> +#define Sha256Round( a, b, c, d, e, f, g, h, i )       \
>> +     t0 = h + Sigma1(e) + Ch(e, f, g) + K[i] + W[i];   \
>> +     t1 = Sigma0(a) + Maj(a, b, c);                    \
>> +     d += t0;                                          \
>> +     h  = t0 + t1;
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  TransformFunction
>> +//
>> +//  Compress 512-bits
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +static
>> +void
>> +    TransformFunction
>> +    (
>> +        Sha256Context*      Context,
>> +        uint8_t const*      Buffer
>> +    )
>> +{
>> +    uint32_t    S[8];
>> +    uint32_t    W[64];
>> +    uint32_t    t0;
>> +    uint32_t    t1;
>> +    uint32_t    t;
>> +    int         i;
>> +
>> +    // Copy state into S
>> +    for( i=0; i<8; i++ )
>> +    {
>> +        S[i] = Context->state[i];
>> +    }
>> +
>> +    // Copy the state into 512-bits into W[0..15]
>> +    for( i=0; i<16; i++ )
>> +    {
>> +        LOAD32H( W[i], Buffer + (4*i) );
>> +    }
>> +
>> +    // Fill W[16..63]
>> +    for( i=16; i<64; i++ )
>> +    {
>> +        W[i] = Gamma1( W[i-2]) + W[i-7] + Gamma0( W[i-15] ) + W[i-16];
>> +    }
>> +
>> +    // Compress
>> +    for( i=0; i<64; i++ )
>> +    {
>> +        Sha256Round( S[0], S[1], S[2], S[3], S[4], S[5], S[6], S[7], i );
>> +        t = S[7];
>> +        S[7] = S[6];
>> +        S[6] = S[5];
>> +        S[5] = S[4];
>> +        S[4] = S[3];
>> +        S[3] = S[2];
>> +        S[2] = S[1];
>> +        S[1] = S[0];
>> +        S[0] = t;
>> +    }
>> +
>> +    // Feedback
>> +    for( i=0; i<8; i++ )
>> +    {
>> +        Context->state[i] = Context->state[i] + S[i];
>> +    }
>> +}
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  PUBLIC FUNCTIONS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Initialise
>> +//
>> +//  Initialises a SHA256 Context. Use this to initialise/reset a context.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Initialise
>> +    (
>> +        Sha256Context*      Context         // [out]
>> +    )
>> +{
>> +    Context->curlen = 0;
>> +    Context->length = 0;
>> +    Context->state[0] = 0x6A09E667UL;
>> +    Context->state[1] = 0xBB67AE85UL;
>> +    Context->state[2] = 0x3C6EF372UL;
>> +    Context->state[3] = 0xA54FF53AUL;
>> +    Context->state[4] = 0x510E527FUL;
>> +    Context->state[5] = 0x9B05688CUL;
>> +    Context->state[6] = 0x1F83D9ABUL;
>> +    Context->state[7] = 0x5BE0CD19UL;
>> +}
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Update
>> +//
>> +//  Adds data to the SHA256 context. This will process the data and update the internal state of the context. Keep on
>> +//  calling this function until all the data has been added. Then call Sha256Finalise to calculate the hash.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Update
>> +    (
>> +        Sha256Context*      Context,        // [in out]
>> +        void const*         Buffer,         // [in]
>> +        uint32_t            BufferSize      // [in]
>> +    )
>> +{
>> +    uint32_t n;
>> +
>> +    if( Context->curlen > sizeof(Context->buf) )
>> +    {
>> +       return;
>> +    }
>> +
>> +    while( BufferSize > 0 )
>> +    {
>> +        if( Context->curlen == 0 && BufferSize >= BLOCK_SIZE )
>> +        {
>> +           TransformFunction( Context, (uint8_t*)Buffer );
>> +           Context->length += BLOCK_SIZE * 8;
>> +           Buffer = (uint8_t*)Buffer + BLOCK_SIZE;
>> +           BufferSize -= BLOCK_SIZE;
>> +        }
>> +        else
>> +        {
>> +           n = MIN( BufferSize, (BLOCK_SIZE - Context->curlen) );
>> +           memcpy( Context->buf + Context->curlen, Buffer, (size_t)n );
>> +           Context->curlen += n;
>> +           Buffer = (uint8_t*)Buffer + n;
>> +           BufferSize -= n;
>> +           if( Context->curlen == BLOCK_SIZE )
>> +           {
>> +              TransformFunction( Context, Context->buf );
>> +              Context->length += 8*BLOCK_SIZE;
>> +              Context->curlen = 0;
>> +           }
>> +       }
>> +    }
>> +}
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Finalise
>> +//
>> +//  Performs the final calculation of the hash and returns the digest (32 byte buffer containing 256bit hash). After
>> +//  calling this, Sha256Initialised must be used to reuse the context.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Finalise
>> +    (
>> +        Sha256Context*      Context,        // [in out]
>> +        SHA256_HASH*        Digest          // [out]
>> +    )
>> +{
>> +    int i;
>> +
>> +    if( Context->curlen >= sizeof(Context->buf) )
>> +    {
>> +       return;
>> +    }
>> +
>> +    // Increase the length of the message
>> +    Context->length += Context->curlen * 8;
>> +
>> +    // Append the '1' bit
>> +    Context->buf[Context->curlen++] = (uint8_t)0x80;
>> +
>> +    // if the length is currently above 56 bytes we append zeros
>> +    // then compress.  Then we can fall back to padding zeros and length
>> +    // encoding like normal.
>> +    if( Context->curlen > 56 )
>> +    {
>> +        while( Context->curlen < 64 )
>> +        {
>> +            Context->buf[Context->curlen++] = (uint8_t)0;
>> +        }
>> +        TransformFunction(Context, Context->buf);
>> +        Context->curlen = 0;
>> +    }
>> +
>> +    // Pad up to 56 bytes of zeroes
>> +    while( Context->curlen < 56 )
>> +    {
>> +        Context->buf[Context->curlen++] = (uint8_t)0;
>> +    }
>> +
>> +    // Store length
>> +    STORE64H( Context->length, Context->buf+56 );
>> +    TransformFunction( Context, Context->buf );
>> +
>> +    // Copy output
>> +    for( i=0; i<8; i++ )
>> +    {
>> +        STORE32H( Context->state[i], Digest->bytes+(4*i) );
>> +    }
>> +}
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Calculate
>> +//
>> +//  Combines Sha256Initialise, Sha256Update, and Sha256Finalise into one function. Calculates the SHA256 hash of the
>> +//  buffer.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Calculate
>> +    (
>> +        void  const*        Buffer,         // [in]
>> +        uint32_t            BufferSize,     // [in]
>> +        SHA256_HASH*        Digest          // [in]
>> +    )
>> +{
>> +    Sha256Context context;
>> +
>> +    Sha256Initialise( &context );
>> +    Sha256Update( &context, Buffer, BufferSize );
>> +    Sha256Finalise( &context, Digest );
>> +}
>> diff --git a/policycoreutils/semodule/sha256.h b/policycoreutils/semodule/sha256.h
>> new file mode 100644
>> index 000000000000..406ed869cd82
>> --- /dev/null
>> +++ b/policycoreutils/semodule/sha256.h
>> @@ -0,0 +1,89 @@
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  WjCryptLib_Sha256
>> +//
>> +//  Implementation of SHA256 hash function.
>> +//  Original author: Tom St Denis, tomstdenis@gmail.com, http://libtom.org
>> +//  Modified by WaterJuice retaining Public Domain license.
>> +//
>> +//  This is free and unencumbered software released into the public domain - June 2013 waterjuice.org
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +#pragma once
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  IMPORTS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +#include <stdint.h>
>> +#include <stdio.h>
>> +
>> +typedef struct
>> +{
>> +    uint64_t    length;
>> +    uint32_t    state[8];
>> +    uint32_t    curlen;
>> +    uint8_t     buf[64];
>> +} Sha256Context;
>> +
>> +#define SHA256_HASH_SIZE           ( 256 / 8 )
>> +
>> +typedef struct
>> +{
>> +    uint8_t      bytes [SHA256_HASH_SIZE];
>> +} SHA256_HASH;
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  PUBLIC FUNCTIONS
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Initialise
>> +//
>> +//  Initialises a SHA256 Context. Use this to initialise/reset a context.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Initialise
>> +    (
>> +        Sha256Context*      Context         // [out]
>> +    );
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Update
>> +//
>> +//  Adds data to the SHA256 context. This will process the data and update the internal state of the context. Keep on
>> +//  calling this function until all the data has been added. Then call Sha256Finalise to calculate the hash.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Update
>> +    (
>> +        Sha256Context*      Context,        // [in out]
>> +        void const*         Buffer,         // [in]
>> +        uint32_t            BufferSize      // [in]
>> +    );
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Finalise
>> +//
>> +//  Performs the final calculation of the hash and returns the digest (32 byte buffer containing 256bit hash). After
>> +//  calling this, Sha256Initialised must be used to reuse the context.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Finalise
>> +    (
>> +        Sha256Context*      Context,        // [in out]
>> +        SHA256_HASH*        Digest          // [out]
>> +    );
>> +
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +//  Sha256Calculate
>> +//
>> +//  Combines Sha256Initialise, Sha256Update, and Sha256Finalise into one function. Calculates the SHA256 hash of the
>> +//  buffer.
>> +////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
>> +void
>> +    Sha256Calculate
>> +    (
>> +        void  const*        Buffer,         // [in]
>> +        uint32_t            BufferSize,     // [in]
>> +        SHA256_HASH*        Digest          // [in]
>> +    );
>> --
>> 2.33.1
>>

