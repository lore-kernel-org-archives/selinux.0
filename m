Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q22MG5XW026093
	for <selinux@tycho.nsa.gov>; Fri, 2 Mar 2012 17:16:05 -0500
Received: by obceq6 with SMTP id eq6so2803976obc.12
        for <selinux@tycho.nsa.gov>; Fri, 02 Mar 2012 14:16:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330719989.2616.100.camel@moss-pluto>
References: <CAD8iFzx70mZyFbqTju=oVm1uLRx=Nic6Y8drsbiM-Vxqw3F8cw@mail.gmail.com>
	<1330702776.2616.43.camel@moss-pluto>
	<CAD8iFzycUJLiZynmHGiUR6s2OJVKRvoQda7n-ktUBxTf-RiFwA@mail.gmail.com>
	<CA+XzHeMaetu1zmC9KNo1VVnPan20neiXiSVYWwyC9ZmS_rx4=w@mail.gmail.com>
	<1330719989.2616.100.camel@moss-pluto>
Date: Fri, 2 Mar 2012 16:16:04 -0600
Message-ID: <CA+XzHePXLxhGxpXrtZ6AzmgZNPoZhRN9p7Em+oOStnJXnhaYiw@mail.gmail.com>
Subject: Re: SE Android on Galaxy Nexus
From: Bryan Hinton <bryan@bryanhinton.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Subramani Venkatesh <selinuxv31@gmail.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I agree. A per-device file_contexts file makes sense given the
variation in radio types between ICS based devices.

On Fri, Mar 2, 2012 at 2:26 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-03-02 at 11:51 -0600, Bryan Hinton wrote:
>> Here is the latest policy that I am using.
>
> BTW, I think we will ultimately need some per-device policy files that
> get merged into the policy, much as there are per-device
> ueventd.<board>.rc and init.<board>.rc files.  At least for
> file_contexts, and possibly for policy rules as well.
>
> --
> Stephen Smalley
> National Security Agency
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
