Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6SDhWgA021029
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 09:43:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6SDapcq004500
	for <selinux@tycho.nsa.gov>; Thu, 28 Jul 2005 13:36:53 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [RFC] selinux management API
Date: Thu, 28 Jul 2005 18:36:01 +1000
Cc: gyurdiev@redhat.com, selinux@tycho.nsa.gov
References: <42D7CC53.9030803@tresys.com> <1121442990.4488.87.camel@celtics.boston.redhat.com> <42D7FC9A.7000901@tresys.com>
In-Reply-To: <42D7FC9A.7000901@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200507281836.06447.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 16 July 2005 04:12, Joshua Brindle <jbrindle@tresys.com> wrote:
> I think this summarizes the dialog well Ivan, thanks.
>
> Attached is an updated header file that uses structs for all

int semanage_module_install(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_upgrade(semanage_handle_t *,
                            char *module_data, size_t data_len);
int semanage_module_install_base(semanage_handle_t *,
                                 char *module_data, size_t data_len);

Is the plan to support binary or text modules for these operations?  If binary 
modules then module_data should have type void *.

Also more liberal use of const would be good.  I expect that the above 
functions will not change the module data so const void * would probably be 
the correct type.  I realise that this is still in the design phase, but I 
think that we are ready to design which data gets modified by the library 
code and which doesn't.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
