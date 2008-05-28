Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4SFRfnZ018691
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 11:27:41 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4SFRcaH005612
	for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 15:27:39 GMT
Received: by fg-out-1718.google.com with SMTP id 16so1776276fgg.40
        for <selinux@tycho.nsa.gov>; Wed, 28 May 2008 08:27:37 -0700 (PDT)
Message-ID: <cadfc0e40805280827k7413e108g8d599b4c246e5c2e@mail.gmail.com>
Date: Wed, 28 May 2008 10:27:37 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Joe Nall" <joe@nall.com>
Subject: Re: rbacsep: collapsing xserver
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Eamon Walsh" <ewalsh@tycho.nsa.gov>
In-Reply-To: <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1211985533.5008.116.camel@gorn.columbia.tresys.com>
	 <ddbc00640805280816i24c06b68u65a7e4d7b68bf213@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 28, 2008 at 10:16 AM, Joe Nall <joe@nall.com> wrote:
> On Wed, May 28, 2008 at 9:38 AM, Christopher J. PeBenito
> <cpebenito@tresys.com> wrote:
>> I've got to the point where I am collapsing the derived types in the
>> xserver module.  It would be nice to collapse all of the X server
>> domains into xserver_t, but we have xdm_xserver_t which has permissions
>> greater than user_xserver_t, staff_server_t, etc.  However, just about
>> everyone runs their xserver in xdm_xserver_t due to logging in via xdm.
>> Thoughts on collapsing all of the xservers anyway?
>
> Why is the way the xserver gets launched important once it is running?
> Does that change when X is an object manager?
>
> On a related topic, what is the type enforcement strategy for window managers?
>
> joe
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>

You mean display managers not window managers, right?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
