Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j71IKogA019903
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2005 14:20:50 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j71IEKQo022691
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2005 18:14:20 GMT
Subject: Re: [RFC] selinux management API
From: Jason Tang <jtang@tresys.com>
To: russell@coker.com.au
Cc: Joshua Brindle <jbrindle@tresys.com>, gyurdiev@redhat.com,
   selinux@tycho.nsa.gov
In-Reply-To: <200507281836.06447.russell@coker.com.au>
References: <42D7CC53.9030803@tresys.com>
	 <1121442990.4488.87.camel@celtics.boston.redhat.com>
	 <42D7FC9A.7000901@tresys.com>  <200507281836.06447.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 14:12:32 -0400
Message-Id: <1122919952.5842.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-28 at 18:36 +1000, Russell Coker wrote:
> int semanage_module_install(semanage_handle_t *,
>                             char *module_data, size_t data_len);
> int semanage_module_upgrade(semanage_handle_t *,
>                             char *module_data, size_t data_len);
> int semanage_module_install_base(semanage_handle_t *,
>                                  char *module_data, size_t data_len);
> 
> Is the plan to support binary or text modules for these operations?  If binary 
> modules then module_data should have type void *.

libsemanage will handle only binary modules.  The caller is assumed to
have invoked checkmodule beforehand.

The reason why these pointers are 'char' is that we want
byte-addressible memory.  It is true that using 'char' can be
misleading, but alas C is deficient here.

-- 
Jason Tang / jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
