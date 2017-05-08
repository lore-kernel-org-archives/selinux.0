Message-ID: <1494250375.4621.1.camel@tycho.nsa.gov>
Subject: Re: Why does Python want to read /proc/meminfo
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ian Pilcher <arequipeno@gmail.com>, dieter <dieter@handshake.de>
Cc: python-list@python.org, selinux <selinux@tycho.nsa.gov>
Date: Mon, 08 May 2017 09:32:55 -0400
In-Reply-To: <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de>
 <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-05-06 at 11:07 -0500, Ian Pilcher wrote:
> On 05/06/2017 12:51 AM, dieter wrote:
> > Personally, I doubt that you will find a reference.
> > Instead, I assume that the reference comes from the C runtime
> > library.
> > It might hepl optimize memory management to know about "meminfo"
> > details.
> 
> You're right.  Seems that it's glibc's qsort().
> 
> So it seems that any service written in Python (or any other program
> that uses qsort) needs to be given read access to most of /proc or
> deal
> with the (unspecified) consequences of not allowing qsort() to
> determine
> the amount of memory in the system.
> 
> Delightful.

Alternatively, assign a specific type to /proc/meminfo and allow read
to it without opening up access to most of /proc.  That is what Android
has done, for example.
