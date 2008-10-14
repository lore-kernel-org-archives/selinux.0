Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9E3math015310
	for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 23:48:36 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9E3maC8009004
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 03:48:36 GMT
Received: by rv-out-0708.google.com with SMTP id f25so2436836rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 13 Oct 2008 20:48:35 -0700 (PDT)
Message-ID: <dd18b0c30810132048s7b1d0263xea6d86bbd6dbee35@mail.gmail.com>
Date: Mon, 13 Oct 2008 20:48:35 -0700
From: "Justin Mattock" <justinmattock@gmail.com>
To: russell@coker.com.au
Subject: Re: gdm ubuntu 8.10
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <dd18b0c30810121424k5aa67d2me25d451166279706@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30810112056r5c107307jbcab88d07a382233@mail.gmail.com>
	 <200810122054.50829.russell@coker.com.au>
	 <dd18b0c30810120718u4f3380bbg3b4f3f63f88b49f2@mail.gmail.com>
	 <dd18b0c30810121424k5aa67d2me25d451166279706@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Oct 12, 2008 at 2:24 PM, Justin Mattock <justinmattock@gmail.com> wrote:
> On Sun, Oct 12, 2008 at 7:18 AM, Justin Mattock <justinmattock@gmail.com> wrote:
>> On Sun, Oct 12, 2008 at 2:54 AM, Russell Coker <russell@coker.com.au> wrote:
>>> On Sunday 12 October 2008 14:56, "Justin Mattock" <justinmattock@gmail.com>
>>> wrote:
>>>> Hello; for a while I've been using nubuntu,but now have decided
>>>> to try a full loaded O.S. when using nubuntu  there is no automatic
>>>> gnome-desktop-manager, normally just a login then choosing a context,
>>>> then startx.
>>>> Now with ubuntu there's an automatic login screen with bells and whistles,
>>>>  what is the best way to add pam_selinux.so so I can choose my context,
>>>> or should I adjust the policy to start in sysadm_r as the default
>>>> instead of user_r?
>>>
>>> Some of the *dm programs have SE Linux support merged (like sshd) so you don't
>>> need pam_selinux.so (it may cause problems).  Some of them don't have SE
>>> Linux code and therefore do need pam_selinux.so.  Some of them might have the
>>> old version of the code in which case the login->user mapping isn't done and
>>> things will go wrong (best not to use it in that case).
>>>
>>> Run ldd and check for libselinux.so, if it's there then you don't want
>>> pam_selinux.so - so it's a matter of testing whether the code in question is
>>> new enough.  If there is no libselinux.so then you can safely use
>>> pam_selinux.so.
>>>
>>> Some of the daemons have only recently been fixed in Lenny, so the broken
>>> versions may still be in Ubuntu.
>>>
>>> --
>>> russell@coker.com.au
>>> http://etbe.coker.com.au/          My Blog
>>>
>>> http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
>>>
>>
>> Cool, thanks for the info on this one,
>> when doing ldd /usr/sbin/gdm there is libselinux
>> when doing ldd /sbin/usplash there isn't. With this in mind
>> I need to examine the order of operations(still shaky with how this
>> mechanism works)
>>  i.g. during bootup gdm is called
>> then after login there's a few second's of nothingness(orange color'ed
>> screen) before the theme song
>> and the rest of the goodies appear. when using pam_selinux.so I
>> noticed when disabling gdm
>> the options to choose the context was not there, until downgrading to
>> sarge/lenny, then was prompted
>> for a context to choose. but unfortunately /etc/init.d/gdm start after
>> the boot process still leaves me in user_r.
>> As for the list of packages I think these are all intrepid.
>>
>> --
>> Justin P. Mattock
>>
>
> O.K. Well I'm not sure if this is correct, but
> what the heck; when using fluxbox and startx
> using "user_r" was next to impossible to achieve(at least for me);
> but this doesn't seem to be the case for ubuntu or gdm(whatever would
> be right to say),
> I am able to run the system in full enforcement in "user_r" rather
> than before having
> to choose "sysadm_r" to "startx",("I guess you learn something new
> everyday afterall").
> The only avc's that seem to not want to be allowed are:
>
> allow hald_t memory_device_t:chr_file write;
> allow system_dbusd_t self:capability sys_module;
> allow vbetool_t self:memprotect mmap_zero;
>
> is this corrected by setting a boolean?
> Anyways overall running in "user_r" was something I wanted to try
> a few months ago,but was unsuccessful(with nubuntu);
> but now doesn't seem to be the case
> regards;
> --
> Justin P. Mattock
>

So after using user_r(which I feel is more safe);
I'm noticing I can't login to sysadm_r.
This role seems to be safe in a corporate environment,
but in my case I'm the only user on this machine as well as
the admin. So after looking in to it setting the boolean
to allow xdm sysadm login and changing the default_contexts file,
I'm able to login as sysadm_r without having to
mess with /etc/pam.d/login stuff.

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
