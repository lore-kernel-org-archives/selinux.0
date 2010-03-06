Message-ID: <4B92E333.9090108@manicmethod.com>
Date: Sat, 06 Mar 2010 18:20:19 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Ed Swierk <eswierk@aristanetworks.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: Re: Apparent memory leak in libselinux
References: <9ae48b020912301632u6d69e445tf2dd33d3afe9ca04@mail.gmail.com>	<1262641016.28009.167.camel@moss-pluto.epoch.ncsc.mil> <9ae48b021001041449w677a7da4rbbca504a32c08f3a@mail.gmail.com>
In-Reply-To: <9ae48b021001041449w677a7da4rbbca504a32c08f3a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ed Swierk wrote:
> On Mon, Jan 4, 2010 at 1:36 PM, Stephen Smalley<sds@tycho.nsa.gov>  wrote:
>> Likely introduced by Eric's short cut for checking /proc/filesystems and
>> bailing immediately in the non-selinux case.  Try this:
>
> There are a couple of other leakage cases to worry about. I submitted
> a patch here: http://userspace.selinuxproject.org/trac/ticket/10
>

Can you send the patch to the list please?

Guidelines on patch preparations are available at:
http://userspace.selinuxproject.org/trac/wiki/Contributing

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
