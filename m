Message-ID: <3B0BC232.1763F0FF@watson.ibm.com>
Date: Wed, 23 May 2001 09:59:14 -0400
From: Reiner Sailer <sailer@watson.ibm.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: PPC port of SELinux
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From: Howard Holm (hdholm@epoch.ncsc.mil)
>Date: Tue 6 Feb 2001 - 15:08:21 EST
>I'm not aware of any port underway to the Power PC, nor is it something

>likely to ever be a priority for the NSA team. If someone else wants
>to port to the Power PC, or in fact has done any work extending the
>system please keep the list informed so that we don't have people
>duplicating each other's work and consider making your work in progress

>available.

I just ported (most of ) the SELinux kernel patch (available at the
SELinux
home page, kernel-2.4.3-200104121417) to work for the MontaVista
(http://www.mvista.com) linux kernel  (2.4.2-mvista-010303 ... ppc
unknown) running
on a PPC 405GP processor in an embedded environment (here: Walnut
board).

The main change has been adapting the system calls to the
PPC architecture and finding the right file counterparts in the
arch/PPC directory.

One thing remains to be solved: I couldn't integrate the SELinux
patch regarding the mmap2 sys call as this system call
seems not implemented by the PPC kernel. Two questions:
1 )  Is there any reason (other than performance) not to put the patch
      into the mmap system call?
2) Is there a short description of the "context" of this patch? The
patch itself
    is easy to read. I am going to try to  integrate this patch, too.
This might take
    a while because I am not yet familiar with the way mmap works.

I know that even getting all the patches to work does not imply that
there are no other
ways to circumvent the patches in the PPC kernel - functions could be
used differently,
called at different places, or even substituted by new functions that
are not implemented
in the i386 kernel (and therefore not considered). Somebody will have to
look at the PPC
kernel before using the PPC port in a commercial environment. Another
question:
3) Is there a test suite (available) that helps to verify whether the
reference monitor
    functions are active in all important control flows?

If there is interest, we will  make this patch available as it is.  It
might
still be at bit of work to make it "patch" into the standard linux PPC
kernel.
[global Makefile will not patch but can be easily adapted, mmap to be
resolved]

Reiner


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
