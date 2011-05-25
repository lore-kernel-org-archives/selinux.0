Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4P2RXf9005199
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 22:27:33 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p4P2RWmK007301
	for <selinux@tycho.nsa.gov>; Wed, 25 May 2011 02:27:32 GMT
Received: by iwn38 with SMTP id 38so7434408iwn.12
        for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 19:27:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201105250853.49540.russell@coker.com.au>
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
	<201105250853.49540.russell@coker.com.au>
Date: Tue, 24 May 2011 19:27:32 -0700
Message-ID: <BANLkTik-1iRWXN5nisHgNh2GYru3WpJbPA@mail.gmail.com>
Subject: Re: Is it possible to assign different labels to symbolic links and
 actual files?
From: Sam Gandhi <samgandhi9@gmail.com>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russell,

On Tue, May 24, 2011 at 3:53 PM, Russell Coker <russell@coker.com.au> wrote:
> On Wed, 25 May 2011, Sam Gandhi <samgandhi9@gmail.com> wrote:
>> I am working on a embedded platform and we have busybox on this device.
>>
>> What we would like to do do is assign diffrent labels to various
>> busybox links. What we have seen when running things on JFFS2 when I
>> label a symbolic link, the actual file gets the label, but the link
>> itself doesn't (according to ls -lZ output).  We have seen similar
>> behaviour with files on tmpfs as well.
>
> SE Linux supports assigning a different label to the sym-link, but that only
> matters when access checks are performed for reading/following the sym-link.
> When it comes to actually running the program the link label means little.
>
> If you want to use labels to determine domain transitions then you can't use
> the sym-link label.  You need to either have a wrapper program that is labeled
> to give the domain transition which then executes busybox, or to have several
> copies of busybox which aggregate only programs which deserve the same domain.
>
> http://doc.coker.com.au/papers/porting-se-linux-hand-held-devices/

That is fantastic! What is described in your paper is, exactly what I
was looking to do.

Thank you SO much.

-Sam


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
