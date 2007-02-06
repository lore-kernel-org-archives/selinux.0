Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l162CFXk009365
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2007 21:12:15 -0500
Received: from ppp1-100.the.forthnet.gr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l162DKd7003678
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 02:13:21 GMT
Received: from ppp1-100.the.forthnet.gr (localhost [127.0.0.1])
	by ppp1-100.the.forthnet.gr (8.13.8/8.13.8/Debian-3) with ESMTP id l162CY0s029000
	for <selinux@tycho.nsa.gov>; Tue, 6 Feb 2007 04:12:34 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by ppp1-100.the.forthnet.gr (8.13.8/8.13.8/Submit) id l162CXF2028999
	for selinux@tycho.nsa.gov; Tue, 6 Feb 2007 04:12:33 +0200
From: Stefanos Harhalakis <v13@priest.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: core dump
Date: Tue, 6 Feb 2007 04:12:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Message-Id: <200702060412.33276.v13@priest.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I had this issue today:

# semodule -i logging.pp 
Segmentation fault (core dumped)

I traced this a bit and it seems that this is because of libsepol. 
The core dump is the result of lines 602:603 of link.c:

(gdb) bt
#0  0xb7f732fd in sens_copy_callback (key=0x848c2a0 "s15", datum=0x848c290, data=0xbfde3854) at link.c:602
#1  0xb7f6f8a1 in hashtab_map (h=0x846cbf0, apply=0xb7f731d1 <sens_copy_callback>, args=0xbfde3854) at hashtab.c:214
#2  0xb7f75528 in copy_identifiers (state=0xbfde3854, src_symtab=0x843cc74, dest_decl=0x0) at link.c:1323
#3  0xb7f77c72 in link_modules (handle=0x804c710, b=0x80525b8, mods=0x863ce18, len=19, verbose=0) at link.c:2178
#4  0xb7f7a2c9 in sepol_link_packages (handle=0x804c710, base=0x8053060, modules=0x80543c8, num_modules=19, verbose=0) at module.c:302

Where:

(gdb) l
597                                 state->cur_mod_name);
598                             return -SEPOL_LINK_NOTSUP;
599                     }
600             }
601     
602             state->cur->map[SYM_LEVELS][level->level->sens - 1] =
603                 base_level->level->sens;
604     
605             return 0;
606     }

Because of:

(gdb) p base_level
$1 = (level_datum_t *) 0x0

The last 'if' checks for !base_level, but inside the 'if' block, only 
!scope and scope->scope==SCOPE_DECL are checked.

This core dump is caused by:

(gdb) p scope->scope
$2 = 1

Which is noted as:

/* Required for this decl */
#define SCOPE_REQ  1

in libsepol/include/sepol/policydb/policydb.h

Hope this helps...

<<V13>>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
