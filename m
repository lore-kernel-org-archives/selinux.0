Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SIajrT009657
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 14:36:45 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SIZhuK001765
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:35:43 GMT
Subject: Re: [patch] types.fc
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095987749.7142.6.camel@gorn.pebenito.net>
References: <1095987749.7142.6.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1096396552.30810.77.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 28 Sep 2004 14:35:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged, except for the ifdef around the java sdk stuff.  This is not
part of Fedora or RHEL (AFAIK), so I don't think that we want the
ifdef.  


 On Thu, 2004-09-23 at 21:02, Chris PeBenito wrote:
> Here's an update of types.fc with a some Gentoo-specific entries,
> against CVS.  Also enclose a few entries with other distro tunables.

> Index: file_contexts/types.fc
> ===================================================================
> RCS file:
> /cvsroot/selinux/nsa/selinux-usr/policy/file_contexts/types.fc,v
> retrieving revision 1.40
> diff -u -r1.40 types.fc
> --- file_contexts/types.fc      23 Sep 2004 19:08:59 -0000      1.40
> +++ file_contexts/types.fc      24 Sep 2004 01:00:59 -0000


> @@ -493,10 +514,12 @@
>  #
>  # The Sun Java development kit, RPM install
>  #
> +ifdef(`distro_redhat', `
>  /usr/java/j2.*/bin(/.*)?               system_u:object_r:bin_t
>  /usr/java/j2.*/jre/lib(64)?/i386(/.*)? system_u:object_r:lib_t
>  /usr/java/j2.*/jre/lib(64)?/i386(/.*)?[^/]*\.so(\.[^/]*)* --
> system_u:object_r:shlib_t
>  /usr/java/j2.*/plugin/i386(/.*)?/lib[^/]*\.so(\.[^/]*)* --
> system_u:object_r:shlib_t
> +')
>  
>  #
>  #  The krb5.conf file is always being tested for writability, so

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
