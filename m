Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8RHpxm4022777
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 13:51:59 -0400
Received: from mail-yx0-f174.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8RHpDun002626
	for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 17:51:13 GMT
Received: by yxe4 with SMTP id 4so4630277yxe.32
        for <selinux@tycho.nsa.gov>; Sun, 27 Sep 2009 10:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090927160540.GA7217@notebook3.grift.internal>
References: <dd18b0c30909262312l1c5a82dfxf9270ecc33b9d64a@mail.gmail.com>
	 <20090927131307.GA4502@notebook2.grift.internal>
	 <4ABF8148.4010108@gmail.com>
	 <20090927160540.GA7217@notebook3.grift.internal>
Date: Sun, 27 Sep 2009 10:51:58 -0700
Message-ID: <dd18b0c30909271051s294643d8sc794ca8dc35e6c16@mail.gmail.com>
Subject: Re: pam_namespace context inside of name.inst
From: Justin Mattock <justinmattock@gmail.com>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 27, 2009 at 9:05 AM, Dominick Grift <domg472@gmail.com> wrote:
> On Sun, Sep 27, 2009 at 08:14:16AM -0700, Justin P. Mattock wrote:
>> Dominick Grift wrote:
>> >On Sat, Sep 26, 2009 at 11:12:20PM -0700, Justin Mattock wrote:
>> >>I'm going crazy over here trying to figure
>> >>out how one system created a context inside
>> >>name.inst one way and another for the other system:
>> >>
>> >>the first system has inside of
>> >>name.inst:
>> >>system_u:object_r:file_t_name
>> >
>> >This is wrong because the fs wasnt labelled properly
>> That's what I figured,(this is the system that I did not label
>> before turning on namespace).
>> >>and on the other system I have:
>> >>
>> >>name:object_r:user_home_dir_t_name
>> >
>> >This is right
>> This is from the system that was labeled before turning on namespace.
>> >>the only difference with the machines is one machine
>> >>had not been labeled yet, before turning on namespace.
>> >>
>> >>what should be the right context directory inside of
>> >>name.inst?
>> >
>> >Depends, i think theres 3 different possibilities (not sure)
>> >
>> >first theres only name (no selinux) which create a dir with the user name
>> >second is context which create a dir with the context of the usre home dir (user_home_dir_t and appends the user name
>> >third is level , which creates a dir with the context of the user home dir and appends the username and also appends the level of the dir.
>> >
>> >>--
>> >>Justin P. Mattock
>> >>
>> >>--
>> >>This message was distributed to subscribers of the selinux mailing list.
>> >>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> >>the words "unsubscribe selinux" without quotes as the message.
>> So either you can use(name,context,level) or (meth=1,2,3)?
>> (I'm wondering if this is all I need to configure)
>
> This is what i use in /etc/security/namespace.conf:
>
> /tmp     /tmp-inst/             level      root,adm
> /var/tmp /var/tmp-inst/         level      root,adm
> $HOME    $HOME/$USER.inst/     level    root,adm
>

 yep, that's what I have as well.

>
> Besides that you would add entries to the related logins in /etc/pam.d/
>
> For example:
> session    required    pam_namespace.so
>
> These entries are often already there.
>
I added that to login, and ssh(gdm if I had it installed)

> And you need to set the boolean:
> allow_polyinstantiation --> on
>
yep.

> Also chmod -R 000 /tmp-inst (and /var/tmp-inst)
> And make sure the have proper labelling:
> [root@notebook3 pam.d]# /usr/sbin/semanage fcontext -l | grep tmp-inst
> /tmp-inst                                          directory          system_u:object_r:tmp_t:s0
> /tmp-inst/.*                                       all files          <<None>>
> /tmp-inst/\.ICE-unix                               directory          system_u:object_r:xdm_tmp_t:s0
> /tmp-inst/\.ICE-unix/.*                            socket             <<None>>
> /tmp-inst/\.X0-lock                                all files          system_u:object_r:xserver_tmp_t:s0
> /tmp-inst/\.X11-unix                               directory          system_u:object_r:xdm_tmp_t:s0
> /tmp-inst/\.X11-unix/.*                            socket             <<None>>
> /tmp-inst/\.font-unix(/.*)?                        all files          system_u:object_r:xfs_tmp_t:s0
> /var/tmp-inst                                      directory          system_u:object_r:tmp_t:s0
>
> After that , the rest should go automaticly. You do not have to manually create /home/joe/joe.inst ( usually this is done for you, and same goes for stuff under there plus stuff under /tmp-inst and /tmp-inst.
>

it was generated. the problem I'm seeing right now is the context is
wrong, because I hadn't labeled the filesystem.

> If however joe.inst is not automatically created on login , than do it manually. also do chmod -R 000 on it and make sure its context is user_home_dir_t.
>
>>
>> Anyways what's getting me is after the initial loading
>> of namespace, the directory is created with the context
>> (namespace.conf is set to it's default).
>> Then after wards I haven't found a way to change that directory
>> (besides using mv, or cp)from what it is(*file_t) to
>> the correct context(*home_dir_t)
>>
>> if I delete that directory, then logout/in namespace does not
>> create another. Is there a way to reset namespace and start fresh
>> since I messed up and turned on namespace before labeling my filesystem,
>> causing it to somehow be stuck with the wrong labeled context?
>
> It should create a new one automatically...

Seems from what I'm looking at /etc/security/namespace.init is called
once for the initial start, then after that is never called again.
(but could be wrong). for now Im going to see if there's a way
to have this mechanism call itself like it had done from the first start,
if so then it should generate a newly created *.inst and be in the
right context.
(if not then Ill manually create it like you had suggested).
>>
>> Justin P. Mattock
>



-- 
Justin P. Mattock


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
