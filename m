Date: Sun, 27 Feb 2005 16:37:43 +0100 (CET)
From: Bartlomiej Balcerek <Bartlomiej.Balcerek@pwr.wroc.pl>
Subject: Re: Assigning user context to files out of home dir.
In-reply-to: <200502252334.55705.russell@coker.com.au>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
Message-id: <Pine.GSO.4.44.0502271604130.24519-100000@sun1000.pwr.wroc.pl>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Feb 2005, Russell Coker wrote:

> It is not valid to use ROLE in the type specification if you don't use
> HOME_DIR in the directory-name specification.  The genhomedircon program
> expects things that way.
>
> What are you trying to do anyway?  Home directories under /scratch will get
> labeled correctly by genhomedircon if the users in question have entries in
> the users file in the policy source directory.

The thing is, users have they home dirs placed as defined in "passwd" file
and "scratch" directories are aside from "homes" (scratch is for some
temporary data and it's structure is similar to homes).

I have:
/home/bartol: bartol:object_r:bartol_home_dir_t

and I want to have:
/scratch/bartol: bartol:object_r:bartol_scratch_dir_t

That is "genhomedircon" won't do for me, I think.

> PS  I'm speaking at the Open Source Security conference in Warsaw.
> http://www.oss.org.pl/en/  Let me know if you are in Warsaw or attending the
> conference.

It is interesting, thanks for that info, I'll let you know soon.

-
Bartlomiej Balcerek
Technical University of Wroclaw, Poland
Wroclaw Centre of Networking and Supercomputing
phone: +48 (71) 320-20-43 mail: bartol@pwr.wroc.pl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
