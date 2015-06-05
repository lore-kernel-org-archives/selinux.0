From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Ravi Kumar <nxp.ravi@gmail.com>,
 "Selinux@tycho.nsa.gov" <Selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: RE: Seeing new denial on AOSP 5.1.1 w.r.t shell request read access
 on lnk_file .
Date: Fri, 5 Jun 2015 15:15:49 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC560101AB76@ORSMSX103.amr.corp.intel.com>
References: <CACikiw1qa82Y1_4wvQOLsijmA=tzSWgWJHbvhQpp=jsSeeX7fQ@mail.gmail.com>
 <55719429.6020108@tycho.nsa.gov>
In-Reply-To: <55719429.6020108@tycho.nsa.gov>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
> Stephen Smalley
> Sent: Friday, June 5, 2015 5:21 AM
> To: Ravi Kumar; Selinux@tycho.nsa.gov; seandroid-list@tycho.nsa.gov
> Subject: Re: Seeing new denial on AOSP 5.1.1 w.r.t shell request read access
> on lnk_file .
> 
> On 06/05/2015 02:31 AM, Ravi Kumar wrote:
> > Hi Team  ,
> > I am seeing some new denial when running the CTS test cases  which is
> > as follows
> >
> > avc: denied { read } for pid=6013 comm="sh" name="app_process"
> > dev="mmcblk0p24" ino=410 scontext=u:r:shell:s0
> > tcontext=u:object_r:zygote_exec:s0 tclass=lnk_file permissive=0
> >
> > where app_process is link created to point app_process32/app_process64
> > binary when doing a  ls -Z  i see the context of this is as expected
> > and  tcontext on the denial  is also as expected (as below ).
> >
> > root# ls -Z |grep app
> > lrwxr-xr-x root     shell             u:object_r:zygote_exec:s0
> > app_process -> app_process64
> > -rwxr-xr-x root     shell             u:object_r:zygote_exec:s0
> > app_process32
> > -rwxr-xr-x root     shell             u:object_r:zygote_exec:s0
> > app_process64
> >
> >
> > I can see that there are NO changes in sepolicy for shell domain /
> > Zygote domain.
> > Only change is the kernel migration from 3.10.48  to 3.10.73(policy
> > version 28)  and i see there are  couple of changes done in security .
> > Looking at the changes  I don't see any suspicious changes which could
> > impact the shell domain nature. Adding the rule is surely  going to
> > addressing the issue but wonder why at first place it is needed  from
> > security point of view i don't think adding just read should create a
> > problem as the  lnk_files is as good as common_file and to as
> > write/execute are not given should not be at risk.  Please let me know
> > if we have any changes which could cause this or any comment on this
> > will be of great help .
> 
> (cc seandroid-list, as that is the list for Android-specific SELinux
> questions)
> 
> On lollipop-mr1-release, we have the following in file_contexts:
> $ grep app_process file_contexts
> /system/bin/app_process32	u:object_r:zygote_exec:s0
> /system/bin/app_process64	u:object_r:zygote_exec:s0
> so the /system/bin/app_process symbolic link should just be labeled
> system_file.
> 

Yes and once you get labeled properly all domains can read system_file
See domain.te: allow domain system_file:lnk_file r_file_perms;
The read permission is required for symbolic links to read the location to follow.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-
> request@tycho.nsa.gov.
