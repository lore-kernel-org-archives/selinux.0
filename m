MIME-Version: 1.0
In-Reply-To: <55314652.7060207@tycho.nsa.gov>
References: <CANnpg5RnMMJ_sK4MqFZzh01ZJwE-kZDKZJ3QjZNn1PD=9UZusw@mail.gmail.com>
 <55314652.7060207@tycho.nsa.gov>
Date: Fri, 17 Apr 2015 19:19:03 -0400
Message-ID: <CANnpg5QwyQdw6J6+ArDDrs7MqoFawAtWvz=V=-wnKN4PJ6AsFw@mail.gmail.com>
Subject: Re: HTCondor process visibility
From: Steve Huston <huston@astro.princeton.edu>
To: Selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Apr 17, 2015 at 1:43 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 04/17/2015 01:31 PM, Steve Huston wrote:
> You also need allow user_t condor_startd_t:process getattr; to see the
> process labels.
>
> I doubt you need lock or ioctl permissions; they tend to get lumped in
> together with read.

Made these changes and it works perfectly.  Thank you kind sir.

> You could alternatively write your rules using macros from the
> refpolicy, e.g.:
> allow user_t condor_startd_t:file read_file_perms;
> allow user_t condor_startd_t:dir list_dir_perms;
> allow user_t condor_startd_t:lnk_file read_lnk_file_perms;
>
> or even using a macro that captures all of these rules in one call, e.g.
> ps_process_pattern(user_t, condor_startd_t)

I'll leave these in my evernote folder for "some day I should learn
this better" :D

-- 
Steve Huston - W2SRH - Unix Sysadmin, PICSciE/CSES & Astrophysical Sci
  Princeton University  |    ICBM Address: 40.346344   -74.652242
    345 Lewis Library   |"On my ship, the Rocinante, wheeling through
  Princeton, NJ   08544 | the galaxies; headed for the heart of Cygnus,
    (267) 793-0852      | headlong into mystery."  -Rush, 'Cygnus X-1'
