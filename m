Message-ID: <4BB34E9D.1020808@manicmethod.com>
Date: Wed, 31 Mar 2010 09:31:09 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Joe Nall <joe@nall.com>
Subject: Re: [RFC] upstream mcstransd to selinux userspace repo
References: <4BB28F38.9020201@tycho.nsa.gov>
In-Reply-To: <4BB28F38.9020201@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> The Red Hat RPM lists the mcstrans upstream as fedora.redhat.com, and I
> have a personal repo that I used to develop the color support.  Joe Nall
> also had a copy hosted at github.org for awhile.
>
> The proposal is to upstream it to the selinux userspace git as a new
> top-level directory.
>

I completely agree that it should be hosted with the other userspace 
components, to avoid further fracturing. I even started reviewing it a 
while back:
http://marc.info/?l=selinux&m=121397658603999&w=2

The main problem at the time was that, to do the MLS things it needed to 
do, it had to duplicate alot of functionality in libsepol, link 
statically against libsepol and do some pretty intrusive things with 
libsepol's private structures.

I don't know what the current state is but I'd really prefer a cleaner 
interface and less duplication of code.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
