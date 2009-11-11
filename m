Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nABH49R1028882
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 12:04:09 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id nABH6AAp006540
	for <selinux@tycho.nsa.gov>; Wed, 11 Nov 2009 17:06:10 GMT
Date: Wed, 11 Nov 2009 12:04:07 -0500
Subject: Re: get security_class_t for objects
From: Chad Sellers <csellers@tresys.com>
To: michel m <michel.mcgregor@gmail.com>, selinux <selinux@tycho.nsa.gov>
Message-ID: <C72058B7.AFD80%csellers@tresys.com>
In-Reply-To: <bb74313d0911110415xf7e6ec7hb0986bf827aa837d@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/11/09 7:15 AM, "michel m" <michel.mcgregor@gmail.com> wrote:

> Hi,
> as an userspace object manager which uses libselinux, I am trying to use
> avc_has_perm(3) for determining access decisions. when I open a file, I can
> get its security context and change it to SID by using fgetfilecon(3) and
> avc_context_to_sid(3), respectively. but when I want to have access decision
> by calling avc_has_perm(3), I am not sure what to pass as the third
> argument,that is security_class_t. I would like to know if there is any API by
> which I can determine an already opened file`s class. may some one direct me
> to a sample code please
> 
You generally figure out that third parameter by using
string_to_security_class() (found in libselinux, discussed in the
selinux_check_passwd_access thread a few days ago). That will convert a
string class name to a security_class_t. As far as an API to determine the
class of an already opened file, fstat() combined with S_ISREG/S_ISDIR/etc.
should do the trick. A bit more work than you might like, but that's how I'd
do it.

Thanks,
Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
