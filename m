Date: Wed, 26 Oct 2016 13:27:51 -0700
From: Harry Waddell <waddell@caravan-epub.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Kashif ali <kashif.ali.9498@gmail.com>, Simon Sekidde
 <ssekidde@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS issue
Message-ID: <20161026132751.36e45a7d@taliesin-3.local>
In-Reply-To: <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
 <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 26 Oct 2016 10:17:27 -0400
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 10/26/2016 03:47 AM, Kashif ali wrote:
> > Hi 
> >    Hope you're fine i know your busy but i need your little time if you
> > can manage that will be great for me.
> > i'm facing an issue in MLS Policy of Selinux when i relabel the system
> > and reboot it it won't allow me to login(i'm signing in my machine ) i
> > used these commands
> >  * set the selinux to enforcing
> >  * touch ./autorelabel for relabeling the system  
> >  * and then reboot the system and it won't allow me to login
> > 
> > Kindly help in this problem because i'm stuck in it for a while and it
> > will be very greatful. Thanks  
> 
> Generally it is a good idea to first bring up the system in permissive
> when switching to MLS, and check that there are no residual denials or
> other SELinux errors that need to be addressed before putting it into
> enforcing mode.  We would need to see the actual error messages to help
> debug further.  And it would help to specify your specific distribution
> and version.
> 

Agreed. At this point, I think the only recourse for Kashif is to 
boot the system into rescue mode, e.g. using the install dvd, 
mount the filesystem, and edit the /etc/sysconfig/selinux file to
change enforcing to permissive. 

Saying "it won't allow me to login" is too vague. Is "me" root?
Is login from the console of via ssh? It could be that a boolean
needs to be changed, but that's just speculation at this point. 
Once it's in permissive mode, hopefully the problem will be somewhat obvious. 
