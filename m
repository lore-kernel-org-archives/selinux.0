Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BIBUTv004786
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 14:11:30 -0400
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BIBST2029043
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 18:11:29 GMT
Received: by wx-out-0506.google.com with SMTP id s17so292543wxc
        for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 11:10:54 -0700 (PDT)
Message-ID: <461D24AC.8040601@gmail.com>
Date: Wed, 11 Apr 2007 13:10:52 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Fwd: Re: seobject.py setransRecords.get_all method return values]
Content-Type: multipart/mixed;
 boundary="------------060009020608020100090405"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060009020608020100090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------060009020608020100090405
Content-Type: message/rfc822;
 name*0="Re: seobject.py setransRecords.get_all method return values"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="Re: seobject.py setransRecords.get_all method return values"

X-Account-Key: account2
Received: by 10.90.91.14 with HTTP; Tue, 10 Apr 2007 07:01:19 -0700 (PDT)
Message-ID: <cadfc0e40704100701w517dd57eo8e14beccc558b839@mail.gmail.com>
Date: Tue, 10 Apr 2007 09:01:19 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: seobject.py setransRecords.get_all method return values
Cc: "Daniel J Walsh" <dwalsh@redhat.com>,
	"Karl MacMillan" <kmacmillan@mentalrootkit.com>
In-Reply-To: <1176211351.15415.144.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3129_32009703.1176213679263"
References: <461A8F2E.5070701@gmail.com>
	 <1176211351.15415.144.camel@moss-spartans.epoch.ncsc.mil>
Delivered-To: txtoth@gmail.com

------=_Part_3129_32009703.1176213679263
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/10/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2007-04-09 at 14:08 -0500, Ted X Toth wrote:
> > When you have aliases in your setrans.conf
> > seobject.setransRecords().get_all returns a dictionary containing values
> > with the last alias whereas the first alias  is what I'd like (this is
> > also what the os uses). Alternatively it could return an ordered list of
> > all of the aliases as the dictionary values or maybe this would be a
> > different method.
>
> Unless such a change would pose a problem for current users of
> seobject.setransRecords().get_all, I'd be fine with changing it to
> return the first alias, and possibly introduce another method if we need
> to return all the aliases (to preserve interface compatibility).  cc'd
> Dan and Karl since they are likely to be more familiar with how this is
> being used today by tools like system-config-selinux.
>
> Do you want to submit a patch or are you making a RFE?
>
> --
> Stephen Smalley
> National Security Agency
>
>
Here's a patch for the first versus last alias. I'm not sure yet about
needing all of the aliases.

Ted

------=_Part_3129_32009703.1176213679263
Content-Type: text/x-patch; name=seobject.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0cf4hk5
Content-Disposition: attachment; filename="seobject.patch"

LS0tIHNlb2JqZWN0LnB5Lm9yaWcJMjAwNy0wMS0xMiAxMDowNToxMi4wMDAwMDAwMDAgLTA2MDAK
KysrIHNlb2JqZWN0LnB5CTIwMDctMDQtMTAgMDg6NDk6NDcuMDAwMDAwMDAwIC0wNTAwCkBAIC0x
NTQsNyArMTU0LDggQEAKIAkJCWlmIGxlbihpKSAhPSAyOgogCQkJCXNlbGYuY29tbWVudHMuYXBw
ZW5kKHIpCiAJCQkJY29udGludWUKLQkJCXNlbGYuZGRpY3RbaVswXV0gPSBpWzFdCisgICAgICAg
ICAgICAgICAgICAgICAgICBpZiBzZWxmLmRkaWN0Lmhhc19rZXkoaVswXSkgPT0gMDoKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzZWxmLmRkaWN0W2lbMF1dID0gaVsxXQogCiAJZGVm
IGdldF9hbGwoc2VsZik6CiAJCXJldHVybiBzZWxmLmRkaWN0Cg==
------=_Part_3129_32009703.1176213679263--


--------------060009020608020100090405--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
