Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9L6Qef5026453
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 02:26:40 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o9L6QbGl008972
	for <selinux@tycho.nsa.gov>; Thu, 21 Oct 2010 06:26:38 GMT
Received: by iwn39 with SMTP id 39so5211011iwn.12
        for <selinux@tycho.nsa.gov>; Wed, 20 Oct 2010 23:26:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBFCC85.60404@gmail.com>
References: <4CBE21ED.4050706@gmail.com>
	<20101020015409.GA19663@hallyn.com>
	<4CBF66AE.5040805@gmail.com>
	<20101021024431.GA25516@hallyn.com>
	<4CBFCC85.60404@gmail.com>
Date: Thu, 21 Oct 2010 11:26:36 +0500
Message-ID: <AANLkTimR6aJYd-OenPjLhUdz4wJLF+r=hUGhUHVikyyN@mail.gmail.com>
Subject: Re: load_policy() with upstart on mint 9 fluxbox
From: Shaz <shazalive@gmail.com>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
        refpolicy@oss1.tresys.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 21, 2010 at 10:15 AM, Justin P. Mattock
<justinmattock@gmail.com> wrote:
> On 10/20/2010 07:44 PM, Serge E. Hallyn wrote:
>>
>> Quoting Justin P. Mattock (justinmattock@gmail.com):
>>>
>>> o.k. finally connected the dots that I needed to create a initrd.img
>>> in order for this to load(im a total newbie!!)
>>>
>>> Anyways the policy loads everything went in and am now in full
>>> enforcement mode.. only real issue is with lxde
>>> same bug here:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=552885
>>>
>>> seems lxde is in /usr/sbin reason probably for the wrong filelabel..
>>
>> Cool, so does following the steps outlined in that bug make it
>> work for you?
>>
>
> What I normally have is /boot/System.map-* and vmlinuz-* to load the
> kernel.. Seems sysvinit knows how to take things there and load_policy()
>
> for upstart whatever it's doing(like what you said) needs to go through
> initrd. Yesterday I though thats what I had done with:
> fakeroot make-kpkg --initrd --append-to-version=-custom kernel_image
> kernel_headers
>
> but missed one last step:
> mkinitramfs -k -o initrd.img-2.6.36-rc8-custom-00022-g2b666ca
> then after doing this everything loaded as is..
>
> Note: guess this is whats being called to do all of this:
> /usr/share/initramfs-tools/scripts/init-bottom/_load_selinux_policy
>
> As for the file labels in /var/run seems most of the files in there are
> labeled with initrc_t (keep in mind I chose debian as the distro in
> build.conf, so maybe this is why)..
>
> As for lxde, before using chcon I was getting a login context of
> name:staff_r:netutils_t:s0 then after relabeling those files:
>
> (chcon to this context like the bug report had shown)
> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm
> system_u:object_r:xdm_exec_t:s0 /usr/sbin/lxdm-binary
> system_u:object_r:xdm_var_run_t:s0 lxdm.pid
>
> I login with the proper context that I chose:
> name:staff_r:staff_t:s0
>
> Right now I think everything is running o.k. on this operating system..
> (nice,small, and functional..with a touch of SELinux on top...)

Dear Justin,

"initrd" helps to load selinux and label "init" so that transitions
can take effect. Be it upstart or sysvinit!

If this is not done then all your processes will be loaded with
unconfined_t. Rest of the details you are considering should not
matter and they might be confusing if you tried to load selinux with
experimentation rather then proper bootstrap through initrd.

Hope this helps.

-- 
Shahbaz Khan
Assit. R&D Engineer,
SERG, IM|Sciences.

http://shazkhan.wordpress.com/
http://pk.linkedin.com/pub/shahbaz-khan/20/116/b49
http://imsciences.edu.pk/serg/
http://csrdu.org/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
