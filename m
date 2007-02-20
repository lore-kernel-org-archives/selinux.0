Subject: Re: libsemanage/Makefile: test target
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: kmacmillan@mentalrootkit.com, jbrindle@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <200702061628.l16GSdCU018039@localhost.localdomain>
References: <200702061628.l16GSdCU018039@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:23:03 -0500
Message-Id: <1171984983.14363.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-06 at 11:28 -0500, Caleb Case wrote:
> The test target now invokes the Makefile in the tests dir.
> ---
>  libsemanage/Makefile |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: selinux-pms-support/libsemanage/Makefile
> ===================================================================
> --- selinux-pms-support.orig/libsemanage/Makefile
> +++ selinux-pms-support/libsemanage/Makefile
> @@ -23,4 +23,5 @@ indent:
>  	$(MAKE) -C src $@
>  	$(MAKE) -C include $@
>  
> -test:
> +test: all
> +	$(MAKE) -C tests test

Merged to -stable and to -trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
