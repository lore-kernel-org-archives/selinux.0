Message-ID: <50534E6B.2020606@manicmethod.com>
Date: Fri, 14 Sep 2012 11:34:03 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: William Roberts <bill.c.roberts@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Update to docs
References: <CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com> <1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2012-09-13 at 16:58 -0700, William Roberts wrote:
>> Can I get the documentation on the wiki updated under "SE Android
>> policy" the second paragraph. I would like to update that you can
>> specify genfs_context files and seapp_context files...maybe something
>> like below will be sufficient:
>>
>> Device-specific additions for the policy configuration can be placed
>> in a sepolicy.te file (for kernel TE policy rules), a sepolicy.fc file
>> (for file_contexts entries), a sepolicy.pc file (for property_contexts
>> entries), a sepolicy.genfs_contexts file (for genfs entries), or
>> seapp_contexts (for seapp rule entries) under any of the
>> target/board/<device>, device/<vendor>/<device>, or
>> vendor/<vendor>/<device>  directories. These files if present are
>> merged into the policy during the build.
>
> Updated.  However, this is starting to get unwieldy.  I was wondering
> whether we should switch over to a model where we permit a sepolicy
> subdirectory under the device directories that can contain any kind of
> policy file (without requiring a sepolicy. prefix on each one since they
> will be in a subdirectory).  Just need to decide how we would merge
> multiple .te files with the same name, i.e. concatenate/union vs.
> replace/override.
>

I'd prefer something like POLICY_FILES += some-policy-file.te.

The reason is that under my maguro directory I now have a full_maguro.mk 
that builds a more-or-less upstream maguro and a tresys_maguro.mk that 
adds stuff we are doing. Right now the policies are all merged because 
there isn't another option but with a POLICY_FILES variable we could 
have custom policy per product.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
