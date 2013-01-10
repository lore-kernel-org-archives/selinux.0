Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0A2gMt7010640
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2013 21:42:22 -0500
From: Alice Chu <alice.chu@sta.samsung.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Date: Wed, 9 Jan 2013 20:41:47 -0600
Subject: RE: Fixing external/libsepol issues found by Klocwork
Message-ID: <C1432A7484D61749AF22A060C2B03C5D1632046A2B@StaEx7mb3.telecom.sna.samsung.com>
References: <C1432A7484D61749AF22A060C2B03C5D1632046A1B@StaEx7mb3.telecom.sna.samsung.com>,<50EC37E2.2000705@tycho.nsa.gov>
In-Reply-To: <50EC37E2.2000705@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Stephen,

Thank you for pointing out the error.  I removed free(s) from symtab_destroy in the new patch. I did not go further to pass in a destroy function to symtab_destroy and invoke hashtab_map() on the table... I think the tool maintainers or someone more familiar with the structures will be more suitable to handle that. I hope the my version of symtab_destroy cleans up memory allocated by symtab_init. I think it does. The followings are the places that call symtab_destroy:
    o expand.c line 255 and 269: when symtab_destroy is called, there should be no hashtab_node struct created that can be referenced through new_common. A cleanup by hashtab_destroy() in symtab_destroy should be sufficient.
    o link.c line 294 and 303: (similar to expand.c) no hashtab_node struct can be referenced through new_class.

Here is the updated patch for further review:
