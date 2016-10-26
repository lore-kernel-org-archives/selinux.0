Date: Wed, 26 Oct 2016 16:08:01 -0700
From: Harry Waddell <waddell@caravan-epub.com>
To: Kashif ali <kashif.ali.9498@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Simon Sekidde <ssekidde@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Subject: Re: MLS issue
Message-ID: <20161026160801.4c1db53b@taliesin-3.local>
In-Reply-To: <CAFC8oaeX5CUVgV_A8hTAGQ7QuWabdw7Zz1geJpB4V_=RWQ3fBg@mail.gmail.com>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
 <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
 <20161026132751.36e45a7d@taliesin-3.local>
 <CAFC8oaeW27J9f4VJTHoCkCS+cD=jb5XA39G46xZBXLOQ74_iYA@mail.gmail.com>
 <20161026134910.5eae6731@taliesin-3.local>
 <CAFC8oaeX5CUVgV_A8hTAGQ7QuWabdw7Zz1geJpB4V_=RWQ3fBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 27 Oct 2016 01:54:02 +0500
Kashif ali <kashif.ali.9498@gmail.com> wrote:

> i'm using centos server and i'm logging on system locally there is no ssh
> and another thing i have checked files are labelled with unlabelled_t, and
> i have installed mlc policy i have checked the logs in audit.log file
> 
> type=AVC msg=audit(1477481078.990:79): avc:  denied  { read } for  pid=1039
> comm="audispd" name="ld.so.cache" dev="dm-0" ino=67387328
> scontext=system_u:system_r:audisp_t:s15:c0.c1023
> tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file
> 
> these kinds of logs are generated
> 
> On Thu, Oct 27, 2016 at 1:49 AM, Harry Waddell <waddell@caravan-epub.com>
> wrote:
> 
> >
> > Again, you're being far too vague. Can you login in text mode as root
> > on the system console? Or are you trying to login to a desktop with a
> > window
> > manage, e.g. via xdm? These are completely different things.
> >
> > 1. Make sure you have the current and correct rpms installed, e.g. the mls
> > policy.
> >
> > 2. Relabel everything again and make sure it completes without errors.
> >
> > 3. If you still can't login in text mode as root from the console, look at
> > the
> > specific causes listed in the auditd log. If you haven't already done so,
> > I would suggest you become good friends with audit2allow, etc...
> >
> > HW
> >
> >
> > On Thu, 27 Oct 2016 01:32:36 +0500
> > Kashif ali <kashif.ali.9498@gmail.com> wrote:
> >  
> > > i am logging on local machine directly and if i put msl in permissive  
> > mode  
> > > it will just generate logs for the policy violation which is expected in
> > > permissive but if i am unable to use mls in enforcing mode then it is  
> > quit  
> > > wrong behavior
> > >
> > > On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell <waddell@caravan-epub.com
> > >
> > > wrote:
> > >  
> > > > On Wed, 26 Oct 2016 10:17:27 -0400
> > > > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >  
> > > > > On 10/26/2016 03:47 AM, Kashif ali wrote:  
> > > > > > Hi
> > > > > >    Hope you're fine i know your busy but i need your little time  
> > if you  
> > > > > > can manage that will be great for me.
> > > > > > i'm facing an issue in MLS Policy of Selinux when i relabel the  
> > system  
> > > > > > and reboot it it won't allow me to login(i'm signing in my machine  
> > ) i  
> > > > > > used these commands
> > > > > >  * set the selinux to enforcing
> > > > > >  * touch ./autorelabel for relabeling the system
> > > > > >  * and then reboot the system and it won't allow me to login
> > > > > >
> > > > > > Kindly help in this problem because i'm stuck in it for a while  
> > and it  
> > > > > > will be very greatful. Thanks  
> > > > >
> > > > > Generally it is a good idea to first bring up the system in  
> > permissive  
> > > > > when switching to MLS, and check that there are no residual denials  
> > or  
> > > > > other SELinux errors that need to be addressed before putting it into
> > > > > enforcing mode.  We would need to see the actual error messages to  
> > help  
> > > > > debug further.  And it would help to specify your specific  
> > distribution  
> > > > > and version.
> > > > >  
> > > >
> > > > Agreed. At this point, I think the only recourse for Kashif is to
> > > > boot the system into rescue mode, e.g. using the install dvd,
> > > > mount the filesystem, and edit the /etc/sysconfig/selinux file to
> > > > change enforcing to permissive.
> > > >
> > > > Saying "it won't allow me to login" is too vague. Is "me" root?
> > > > Is login from the console of via ssh? It could be that a boolean
> > > > needs to be changed, but that's just speculation at this point.
> > > > Once it's in permissive mode, hopefully the problem will be somewhat
> > > > obvious.
> > > >
> > > >
> > > >
> > > >
> > > >  
> >  

I apologize for top-posting earlier. It was momentary insanity on my part. 

Look at the tcontext in the error message. ld.so.conf is unlabeled. 

I'm not sure what it should be on your system, e.g. ld_so_cache_t, but I
strongly suspect unlabeled_t is not correct. You've probably skipped a step somewhere or
something failed without being noticed during setup. 

I suspect you made a mistake here: 

> touch ./autorelabel for relabeling the system
        
It's "touch /.autorelabel", i.e. the dot comes AFTER the / NOT BEFORE. 

Relabel everything. If that doesn't work, consider starting over, paying close attention
to whatever instructions or tutorial you are working from, e.g. 
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security-Enhanced_Linux/enabling-mls-in-selinux.html

HW
