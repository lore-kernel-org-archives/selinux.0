Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GGRPwp029433
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 12:27:39 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GGRcwH025084
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 16:27:38 GMT
Subject: Re: [refpolicy] pam_selinux(gdm-password:session): Security Context
 justin:staff_r:insmod_t:s0 Assigned
From: Guido Trentalancia <guido@trentalancia.com>
To: "Justin P. Mattock" <justinmattock@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, tresys <refpolicy@oss1.tresys.com>,
        SE-Linux <selinux@tycho.nsa.gov>
Date: Fri, 16 Sep 2011 18:27:32 +0200
In-Reply-To: <4E7376D5.3060604@yahoo.com>
References: <1316144432.85313.YahooMailNeo@web114304.mail.gq1.yahoo.com>
	  <4E736453.8000506@redhat.com> <4E7369AF.3000709@yahoo.com>
	 <1316188965.2225.48.camel@vortex> <4E7376D5.3060604@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316190453.2225.57.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-16 at 09:18 -0700, Justin P. Mattock wrote:
> On 09/16/2011 09:02 AM, Guido Trentalancia wrote: 
> > getsebool -a
> at the bottom of the fpaste 
> as for init
> lrwxrwxrwx. root root system_u:object_r:bin_t:s0       /sbin/init
> -> ../bin/systemd

That's the label of the link. Need the label of the target:

ls -lZ /bin/systemd

or whatever that is.

> looks like somewhere somehow the label was labeled wrong.
> stange, I loaded refpolicy(mcs) from fedora's targeted then did sudo
> make relabel from refpolicy even fixfiles relabel at another point in
> time. there is no patch needed for systemd? that needs to be added to
> refpolicy-git?

Moving from Fedora targeted to refpolicy mcs is not just exactly a very
straight thing. As far as I remember when I first installed refpolicy I
hit the init_upstart boolean issue. That's why I recommend you look up
your init_systemd boolean:

setsebool init_systemd=on

> Justin P. Mattock

Guido


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
