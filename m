Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3L9s5O0032698
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 05:54:05 -0400
Received: from atoll.udmvt.ru (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3L9s1rL018847
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 09:54:04 GMT
Received: from ruber.office.udmvt.ru (ruber.office.udmvt.ru [192.168.21.33])
	by atoll.udmvt.ru (8.13.6/8.13.6/Izhcom-V1.1e) with SMTP id n3L9rssQ003632
	for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2009 14:53:57 +0500 (SAMST)
	(envelope-from spg@udmvt.ru)
Date: Tue, 21 Apr 2009 14:53:54 +0500
From: Alexey S <selinux@udmvt.ru>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Bandan Das <bandan.das@stratus.com>, selinux <selinux@tycho.nsa.gov>,
        "Johnson, Richard" <Richard.Johnson@stratus.com>
Subject: Re: genhomedircon errors with NIS
Message-ID: <20090421095354.GG9889@ruber.office.udmvt.ru>
References: <1240253643.7743.78.camel@BSD.mno.stratus.com> <49ECC813.5050403@redhat.com> <1240256165.7743.92.camel@BSD.mno.stratus.com> <49ECD200.8000104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49ECD200.8000104@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 20, 2009 at 03:50:24PM -0400, Daniel J Walsh wrote:
> On 04/20/2009 03:36 PM, Bandan Das wrote:
>> ...
> genhomedircon on RHEL5 is a python script so you can edit it and have it  
> exit on start or ignore /h
>
> But if we update policycoreutils, you changes would get overwritten.
>
> I believe this works but I never tried it.
>
> Add the following to /etc/selinux/semanage.conf and it will use the  
> alternate script instead of the standard
>
>
> [genhomedircon]
> path = /usr/local/sbin/genhomedircon_modified args = -t $@
> [end]
>
>
>
>
> [genhomedircon]
> path = /usr/bin/true args = -t $@
> [end]
>
> would cause it to always succeed and do nothing.  ( I think.)
Wouldn't it be better to not try to autogenerate the list of directories to be labeled
with home_root_t ?
Why is that impossible to generate that list once and save it somewhere in /etc/ and allow
sysadmin to edit that list to suit his needs?
Make the first autogeneration loud and verbose and document that config everywhere.
You can't guess every possible system's configuration anyway.

-- 
Alexey S

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
