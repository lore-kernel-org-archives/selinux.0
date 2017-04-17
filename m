Reply-To: dwalsh@redhat.com
Subject: Re: let's revert e3cab998b48ab293a9962faf9779d70ca339c65d
References: <20170414145759.GA7980@markus>
 <1492184005.26072.3.camel@tycho.nsa.gov>
 <fdcf2bd0-6a5a-aead-ef31-59b9b2235afe@redhat.com>
 <1492192590.26072.5.camel@tycho.nsa.gov> <20170414184946.GB16153@markus>
 <CAJfZ7==rsOexenE+76YX0fbgX9_eXGjygmNzaHL1G8azKk8EMw@mail.gmail.com>
 <1492202486.26072.8.camel@tycho.nsa.gov>
 <2844f689-2726-886f-f824-35723ef57742@redhat.com>
 <1492436089.12012.3.camel@tycho.nsa.gov>
 <c0132d43-1fd7-5e40-3276-2eaa5cb5901d@redhat.com>
 <1492440543.12012.5.camel@tycho.nsa.gov>
To: Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Iooss <nicolas.iooss@m4x.org>,
 selinux <selinux@tycho.nsa.gov>, Dominick Grift <dac.override@gmail.com>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <22df8643-a5d2-b809-ac97-c82adc373dbe@redhat.com>
Date: Mon, 17 Apr 2017 11:08:48 -0400
MIME-Version: 1.0
In-Reply-To: <1492440543.12012.5.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/17/2017 10:49 AM, Stephen Smalley wrote:
> On Mon, 2017-04-17 at 10:40 -0400, Daniel Walsh wrote:
>> On 04/17/2017 09:34 AM, Stephen Smalley wrote:
>>> On Sat, 2017-04-15 at 06:23 -0400, Daniel Walsh wrote:
>>>> I believe that libselinux still reports that the system is
>>>> running
>>>> with
>>>> SELinux, if the selinuxfs is not mounted
>>>> inside of the container at all.
>>> Not after the commit referenced in the subject line; you removed
>>> the
>>> fallback code to check /proc/filesystems for selinuxfs from
>>> is_selinux_enabled(), so if selinuxfs is not mounted at all, it
>>> will
>>> return 0 (not enabled).  On non-Android, you can also cause
>>> is_selinux_enabled() to return 0 by not providing an
>>> /etc/selinux/config file in your container's root directory (see
>>> commit
>>>  
>>> c08c4eacab8d55598b9e5caaef8a871a7a476cab), i.e. as long as you do
>>> not
>>> install selinux-policy in your container root, then it will return
>>> disabled.
>> That seems to a chancy way of handling this.  Since I can see it as
>> pretty easy to accidently pull in selinux-policy package into a
>> container and then the container gets /etc/selinux/config and stuff
>> starts blowing up.  Not sure why the availability of this file should
>> indicate selinux is enabled.
> The existence of /etc/selinux/config is necessary but not sufficient;
> is_selinux_enabled() only returns 1 if selinuxfs is mounted (read-write 
> with the current logic) _and_ (on non-Android) if /etc/selinux/config
> exists.  The /etc/selinux/config test was added to avoid a regression
> when we dropped the old no-policy-loaded test.
>
> In any event, not mounting selinuxfs within the container would suffice
> to cause is_selinux_enabled() to return 0.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

If that is the case, then I have no problem removing the read/only
check.  We can

make sure /sys/fs/selinux is not mounted into the container.
