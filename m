Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAFAC43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881DF2146E
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 16:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoEi+WEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388334AbfBOQuU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:50:20 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44022 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbfBOQuU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 11:50:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id m35so4538619ede.10
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7u8nlB7a4ADWZrIIIuYwbP8cwWGzbBk6IyC7dJPlhbc=;
        b=JoEi+WEgfLn0Holf7X4n7kkQ+HX/IqcIT6YM7jofvVU30ua779ufqH2ntxnG08ju3T
         /WFkNYH6niy93UF6EnI5UPClrSwVJvTsXrOJPg4aUVPIMhr2uIEwXyZLarwY7/MS2H1X
         I3RaPfZZ3HiKhAH7jSjM3vEnVuJJGiwqDFue+LfPY34Kq+M4xPatsz29kB15uKgtwC92
         /ThGuGvs1CdA5lfXXdMLi2DGdBzBSrHaKbUD7U1QpxdmXyFWl4c2WJV4d/wBpnI3/YE1
         VN7DUOvkCQqEwo8ODbzNeRVaUXbYVL4FCKjekI/QUeeouziq3pDQAM9BdHgoNAo5v1E1
         qwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=7u8nlB7a4ADWZrIIIuYwbP8cwWGzbBk6IyC7dJPlhbc=;
        b=PJJOC64WeyggJB8D/QJMyloEzSOAYjk6xnLBBCCuI/hD5PsyartAtTnjXCiveQ6Z0z
         HP4YBLb1HXaspKX3LOSuVeu9LHauVmeFCj+qS8clFTewdUrI2fBo/PLHkB7GzSLZEsJp
         +ZQFBIo1BjAJQzVFnyp51dX0o0H8Ga33G3sC8n2GS3L5sPSr+N7ztburI29hPyba29jH
         FS5dOWLZE8/a2jci8WkKwuuo0kBz58GC0cq120RUOptQa/+9iW0xf4ywmZUAbEbYeRMT
         iRJ9Juz6Ok6fb2OySeogDXCunAqqU5u6bPmFv+RodDWYiIOMs6H8Jtndk5Z/QdaLxDq4
         hGfg==
X-Gm-Message-State: AHQUAubPNQw/F1/FG1+/Oujb3SANrnebmEXI1YVD0MCurqVvFIKGK+4L
        HLrDoXV36O/ceunBTfE81+pgN8lO
X-Google-Smtp-Source: AHgI3IbinPAOj8w6WDu1PXp5PqKpTh007hWEhaazRnV4l0YwRsSe5kuEEgh4HiylPCK3qE0AwrXigQ==
X-Received: by 2002:a50:adfa:: with SMTP id b55mr8451619edd.160.1550249416260;
        Fri, 15 Feb 2019 08:50:16 -0800 (PST)
Received: from brutus (brutus.defensec.nl. [2001:985:d55d::438])
        by smtp.gmail.com with ESMTPSA id m4sm1339169ejl.68.2019.02.15.08.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 08:50:15 -0800 (PST)
From:   Dominick Grift <dac.override@gmail.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] scripts/selinux: add basic mls support to mdp
References: <20190215145045.31945-1-sds@tycho.nsa.gov>
        <CAHC9VhS+F-QBU-oJpXw1aAP1=TpekD1GEYB8y-QqEib1mzbwMA@mail.gmail.com>
        <5c95e956-6d38-78dd-75e2-df2c37bd998a@tycho.nsa.gov>
        <3f279367-2c4f-5b26-e31b-58eb037b687b@tycho.nsa.gov>
        <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov>
Date:   Fri, 15 Feb 2019 17:50:14 +0100
In-Reply-To: <5da1e226-1c75-a732-7d92-89a9dfd4c857@tycho.nsa.gov> (Stephen
        Smalley's message of "Fri, 15 Feb 2019 10:25:08 -0500")
Message-ID: <877ee1m1x5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 2/15/19 10:05 AM, Stephen Smalley wrote:
>> On 2/15/19 10:03 AM, Stephen Smalley wrote:
>>> On 2/15/19 10:00 AM, Paul Moore wrote:
>>>> On Fri, Feb 15, 2019 at 9:51 AM Stephen Smalley
>>>> <sds@tycho.nsa.gov> wrote:
>>>>> Add basic MLS policy support to mdp.=C2=A0 Declares
>>>>> two sensitivities and two categories, defines
>>>>> mls constraints for all permissions requiring
>>>>> dominance (ala MCS), assigns the system-high
>>>>> level to initial SID contexts and the default user
>>>>> level, and assigns system-low level to filesystems.
>>>>>
>>>>> Also reworks the fs_use and genfscon rules to only
>>>>> generate rules for filesystems that are configured
>>>>> in the kernel.=C2=A0 In some cases this depends on a specific
>>>>> config option for security xattrs, in other cases security
>>>>> xattrs are unconditionally supported by a given filesystem
>>>>> if the filesystem is enabled, and in some cases the filesystem
>>>>> is always enabled in the kernel.=C2=A0 Dropped obsolete pseudo
>>>>> filesystems.
>>>>>
>>>>> NB The list of fs_use_* and genfscon rules emitted by mdp
>>>>> is very incomplete compared to refpolicy or Android sepolicy.
>>>>> We should probably expand it.
>>>>>
>>>>> Usage:
>>>>> scripts/selinux/mdp/mdp -m policy.conf file_contexts
>>>>> checkpolicy -M -o policy policy.conf
>>>>>
>>>>> Then install the resulting policy and file_contexts as usual.
>>>>>
>>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>> ---
>>>>> v3 fixes up the file contexts generation code to also use SYSTEMLOW a=
nd
>>>>> collapse down to a single fprintf call per line.
>>>>> =C2=A0 scripts/selinux/mdp/mdp.c | 131
>>>>> ++++++++++++++++++++++++++++++--------
>>>>> =C2=A0 1 file changed, 103 insertions(+), 28 deletions(-)
>>>>
>>>> This is great Stephen, thanks for working on this - and rather quickly
>>>> too!=C2=A0 For those who don't follow the GitHub issues, I just opened=
 an
>>>> issue yesterday mentioning it would be nice to add MLS support to the
>>>> mdp tool.
>>>>
>>>> Are you planning to keep playing with this?=C2=A0 I'm asking not becau=
se I
>>>> think it needs more work to be worthwhile, but rather I don't want to
>>>> merge something that you want to continue working on.=C2=A0 If you are
>>>> happy with this latest patch I think it is okay to merge this into
>>>> selinux/next, even at this late stage, simply because it is not part
>>>> of a built kernel, but rather a developer's tool.
>>>
>>> No, I think I'm done for now unless you find a problem with it.
>>> Absent some compelling use case for mdp it is hard to justify
>>> spending any more time on it.
>>
>> Note however that the instructions in
>> Documentation/admin-guide/LSM/SELinux.rst just say to run
>> scripts/selinux/install_policy.sh and since that doesn't pass -m to
>> mdp or -M to checkpolicy, no one will use this support unless they
>> do it all by hand.
>
> FWIW, a Fedora system wouldn't come up cleanly with this policy.
> Partly appears to be due to systemd having embedded security contexts
> specific to Fedora/refpolicy into its own configurations and partly
> due to MLS denials.  I don't even know if it would work before this
> change though...

Interesting. Can you be more specific? I can boot my dssp2 policy on
fedora just fine.

The only thing you might want to do is relabeling the underlying
mountpoints. Beccause if you install mdp and then relabel the
filesystem, there are a lot of filesystems mounted over mislabeled
mountpoints

you'd do a bind --mount / /mnt

And then label those there. Example from dssp2:


When installing dssp2-standard on an existing fedora installation some cont=
exts of directories in the root filesystem become invalid

mount --bind / /mnt
chcon -u sys.id -r sys.role -t fs.sysfs.fs /mnt/sys
chcon -u sys.id -r sys.role -t files.generic_runtime.runtime_file /mnt/run
chcon -u sys.id -r sys.role -t files.home.file /mnt/home
chcon -u sys.id -r sys.role -t fs.proc.fs /mnt/proc
chcon -u sys.id -r sys.role -t fs.devtmpfs.fs /mnt/dev
chcon -u sys.id -r sys.role -t files.generic_boot.boot_file /mnt/boot
chcon -R -u sys.id -r sys.role -t fs.tmpfs.fs /mnt/tmp
setenforce 0
rm -f /mnt/tmp/ks-script-*
setenforce 1
umount /mnt
umount /boot/efi
restorecon -RF /boot/efi
mount /dev/sda1 /boot/efi
setsebool -P sys.mounton_invalid_dir off

>
>>
>>>
>>>>
>>>>> diff --git a/scripts/selinux/mdp/mdp.c b/scripts/selinux/mdp/mdp.c
>>>>> index 073fe7537f6c..4223e2fea441 100644
>>>>> --- a/scripts/selinux/mdp/mdp.c
>>>>> +++ b/scripts/selinux/mdp/mdp.c
>>>>> @@ -33,6 +33,7 @@
>>>>> =C2=A0 #include <unistd.h>
>>>>> =C2=A0 #include <string.h>
>>>>> =C2=A0 #include <sys/socket.h>
>>>>> +#include <linux/kconfig.h>
>>>>>
>>>>> =C2=A0 static void usage(char *name)
>>>>> =C2=A0 {
>>>>> @@ -95,10 +96,31 @@ int main(int argc, char *argv[])
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n");
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* NOW PRINT OUT MLS STUFF */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* print out mls declarations a=
nd constraints */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mls) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 printf("MLS not yet implemented\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 exit(1);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sensitivity s0;\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sensitivity s1;\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "dominance { s0 s1 }\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "category c0;\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "category c1;\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "level s0:c0.c1;\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "level s1:c0.c1;\n");
>>>>> +#define SYSTEMLOW "s0"
>>>>> +#define SYSTEMHIGH "s1:c0.c1"
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for (i =3D 0; secclass_map[i].name; i++) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct s=
ecurity_class_mapping *map =3D
>>>>> &secclass_map[i];
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(=
fout, "mlsconstrain %s {\n",
>>>>> map->name);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (j =
=3D 0; map->perms[j]; j++)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\t%s\n", map->perms[=
j]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
This requires all subjects and objects to be
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
single-level (l2 eq h2), and that the
>>>>> subject
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
level dominate the object level (h1 dom h2)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * =
in order to have any permissions to it.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(=
fout, "} (l2 eq h2 and h1 dom
>>>>> h2);\n\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* types, roles, and=
 allows */
>>>>> @@ -108,34 +130,87 @@ int main(int argc, char *argv[])
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; seccla=
ss_map[i].name; i++)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "allow base_t base_t:%s *;\n",
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 secclass_map[i].name);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "user user_u role=
s { base_r };\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "user user_u role=
s { base_r }");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mls)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, " level %s range %s - %s", SYSTEMHIGH,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYSTEMLO=
W, SYSTEMHIGH);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, ";\n");
>>>>> +
>>>>> +#define USERROLETYPE "user_u:base_r:base_t"
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* default sids */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 1; i < in=
itial_sid_to_string_len; i++)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sid %s user_u:base_r:base_t\n",
>>>>> initial_sid_to_string[i]);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fprintf(fout, "sid %s " USERROLETYPE "%s\n",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 initial_=
sid_to_string[i], mls ? ":"
>>>>> SYSTEMHIGH : "");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "\n");
>>>>>
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr ext=
2 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr ext=
3 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr ext=
4 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr jfs=
 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr xfs=
 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr rei=
serfs user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr jff=
s2 user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_xattr gfs=
2 user_u:base_r:base_t;\n");
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task even=
tpollfs
>>>>> user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task pipe=
fs user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_task sock=
fs user_u:base_r:base_t;\n");
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans mqu=
eue user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans dev=
pts user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans hug=
etlbfs
>>>>> user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans tmp=
fs user_u:base_r:base_t;\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_trans shm=
 user_u:base_r:base_t;\n");
>>>>> -
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "genfscon proc / =
user_u:base_r:base_t\n");
>>>>> +#define FS_USE(behavior, fstype)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "fs_use_%s %s " U=
SERROLETYPE "%s;\n", \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 behavior, fstype, mls ? ":" SYSTEMLOW : "")
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose inode=
 labels can be fetched via getxattr.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +#ifdef CONFIG_EXT2_FS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_EXT3_FS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext3");
>>>>> +#endif
>>>>> +#ifdef CONFIG_EXT4_FS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "ext4");
>>>>> +#endif
>>>>> +#ifdef CONFIG_JFS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "jfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_REISERFS_FS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "reiserfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_JFFS2_FS_SECURITY
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "jffs2");
>>>>> +#endif
>>>>> +#ifdef CONFIG_XFS_FS
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "xfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_GFS2_FS
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("xattr", "gfs2");
>>>>> +#endif
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose inode=
s are labeled from allocating task.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "pipefs");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "sockfs");
>>>>> +#ifdef CONFIG_POSIX_MQUEUE
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("task", "mqueue");
>>>>> +#endif
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose inode=
 labels are computed from both
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the allocating task and=
 the superblock label.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +#ifdef CONFIG_UNIX98_PTYS
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "devpts");
>>>>> +#endif
>>>>> +#ifdef CONFIG_HUGETLBFS
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "hugetlbfs");
>>>>> +#endif
>>>>> +#ifdef CONFIG_TMPFS
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FS_USE("trans", "tmpfs");
>>>>> +#endif
>>>>> +
>>>>> +
>>>>> +#define GENFSCON(fstype, prefix)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "genfscon %s %s "=
 USERROLETYPE "%s\n", \
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 fstype, prefix, mls ? ":" SYSTEMLOW : "")
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Filesystems whose inode=
s are labeled from path prefix match
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * relative to the filesys=
tem root.=C2=A0 Depending on the
>>>>> filesystem,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only a single label for=
 all inodes may be supported.
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENFSCON("proc", "/");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENFSCON("selinuxfs", "/");
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(fout);
>>>>>
>>>>> @@ -144,8 +219,8 @@ int main(int argc, char *argv[])
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Wrote policy, but cannot open %s for
>>>>> writing\n", ctxout);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 usage(argv[0]);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/ user_u:base_r:=
base_t\n");
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/.* user_u:base_=
r:base_t\n");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/ " USERROLETYPE=
 "%s\n", mls ? ":"
>>>>> SYSTEMLOW : "");
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(fout, "/.* " USERROLETY=
PE "%s\n", mls ? ":"
>>>>> SYSTEMLOW : "");
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fclose(fout);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> --=20
>>>>> 2.20.1
>>>>>
>>>>
>>>>
>>>
>>
>

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift
