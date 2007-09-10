Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8AIdbkE006651
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 14:39:37 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8AIdZif018015
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 18:39:35 GMT
Message-ID: <46E58E05.9060000@hp.com>
Date: Mon, 10 Sep 2007 14:33:41 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: error with polyinstantiation and mcstransd
References: <FB39F4E77226B448BC1388D3BE4E00CD0219E947@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD0219E947@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> When I try to set my level to multiple compartments using newrole, it
> fails because of an error with the polyinstantiation of the /tmp
> directory. This only happens when I am running the mcstransd daemon. I'm
> using RHEL5.

You might try updating your mcstransd package.  Both HP and IBM
certified with a package newer than what's in RHEL5.  Look here:
ftp://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/HP/RPMS/
or here:
ftp://ftp.redhat.com/pub/redhat/linux/eal/EAL4_RHEL5/IBM/RPMS/

I suggest updating all the packages contained there if you
haven't already.

-- ljk

> 
> Here is what I'm trying to do: "newrole -l Z10,Z30"
> 
> Here is the error that I get:
> Warning!  Could not set new context for /dev/pts/2
> pam_open_session failed with Cannot make/remove an entry for the
> specified session
> 
> Z10 and Z30 are translated to s4:c10 and s4:c30 by mcstransd
> 
> I have debugging turned on. Here is the error messages that I get in the
> /var/log/secure file:
> Sep 10 14:41:37 m2blade5 newrole: pam_namespace(newrole:session): Error
> setting context of
> /tmp-inst/system_u:object_r:tmp_t:TS:Z10,Z30-SystemHigh_clarkson to
> system_u:object_r:tmp_t:TS:Z10,Z30-SystemHigh
> Sep 10 14:41:37 m2blade5 newrole: pam_namespace(newrole:session): Error
> mounting
> /tmp-inst/system_u:object_r:tmp_t:TS:Z10,Z30-SystemHigh_clarkson on
> /tmp, No such file or directory
> 
> It has a problem with the level of TS:Z10,Z30-SystemHigh in the security
> context.
> 
> I works fine if I use a single compartment like "newrole -l Z10". It
> also works fine if I stop the mcstransd daemon and use the actual
> sensitivity/category: "newrole -l s4:c10,c30"
> 
> Here are the applicable entries from my setrans.conf file:
> s0=SystemLow
> s1=U
> s2=C
> s3=S
> s4=TS
> s4:c10=Z10
> s4:c20=Z20
> s4:c30=Z30
> s4:c40=Z40
> s4:c0.c255=SystemHigh
> s0-s4:c0.c255=SystemLow-SystemHigh
> 
> Any ideas on how to fix this?
> 
> Thanks
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
