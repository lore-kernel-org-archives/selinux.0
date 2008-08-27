Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7RG8wYN019462
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 12:08:58 -0400
Received: from mail-gx0-f12.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7RG8vJV021200
	for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 16:08:57 GMT
Received: by gxk5 with SMTP id 5so3913010gxk.18
        for <selinux@tycho.nsa.gov>; Wed, 27 Aug 2008 09:08:57 -0700 (PDT)
Message-ID: <80d7e4090808270908p1453e001g2c26f8f7b06709f4@mail.gmail.com>
Date: Wed, 27 Aug 2008 10:08:56 -0600
From: "Stephen John Smoogen" <smooge@gmail.com>
To: "Murray McAllister" <mmcallis@redhat.com>
Subject: Re: user guide draft: "Introduction" review
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <48B4EAE2.302@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48B4EAE2.302@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 26, 2008 at 11:49 PM, Murray McAllister <mmcallis@redhat.com> wrote:
> Hi,
>

Hi, I have only a couple of things that came up in reading.

> The following is a draft of the Introduction sections for the SELinux User
> Guide. Any comments and corrections are appreciated.
>
> Thanks.
>
>  On Linux(R) operating systems, files, directories, sockets, devices, and so
> on, are called objects, and processes, such as a user running a command, the
> Mozilla(R) Firefox(R) application, and the Apache HTTP Server, are called
> subjects. Linux operating systems use a Discretionary Access Control (DAC)
> system that controls how subjects interact and access objects, and how
> subjects interact with each other. On systems using DAC, users control the
> permissions of objects (files and directories) that they own. They could,
> for example, make their home directories world-readable, giving users and
> subjects (processes) access to potentially sensitive information.
>

Should all (R) be listed at the bottom of the chapter with who owns
the registered trademark? I only ask because I am trying to figure out
who has a trademark for the word Enforcement later on.




> * Prevention against privilege escalation. Since subjects run in domains,
> and are therefore separated from each other, and rules determine how
> subjects access objects and other subjects, if a service is compromised, the
> attacker only has access to the normal functions of that service, and to
> files that the service has been configured to have access to. For example,
> if the Apache HTTP Server is compromised, an attacker is unable to read
> files in user home directories, unless a specific rule was added or
> configured to allow such access.
>

I worry about the word prevention.. it implies impossibility. Selinux
discourages privilege escalation but a hole in a policy could still
allow for privilege escalation.


> [1] "Integrating Flexible Support for Security Policies into the Linux
> Operating System", by Peter Loscocco and Stephen Smalley. This paper was
> originally prepared for the National Security Agency and is, consequently,
> in the public domain. Refer to the
> [http://www.nsa.gov/selinux/papers/freenix01/freenix01.html original paper]
> for details and the document as it was first released. Any edits and changes
> were done by Murray McAllister.
>
> [2] "Meeting Critical Security Objectives with Security-Enhanced Linux", by
> Peter Loscocco and Stephen Smalley. This paper was originally prepared for
> the National Security Agency and is, consequently, in the public domain.
> Refer to the [http://www.nsa.gov/selinux/papers/ottawa01/index.html original
> paper] for details and the document as it was first released. Any edits and
> changes were done by Murray McAllister.
>




-- 
Stephen J Smoogen. -- BSD/GNU/Linux
How far that little candle throws his beams! So shines a good deed
in a naughty world. = Shakespeare. "The Merchant of Venice"

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
