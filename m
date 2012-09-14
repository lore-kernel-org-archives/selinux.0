Message-ID: <1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Update to docs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 14 Sep 2012 08:51:23 -0400
In-Reply-To: <CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
References: 
	<CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-09-13 at 16:58 -0700, William Roberts wrote:
> Can I get the documentation on the wiki updated under "SE Android
> policy" the second paragraph. I would like to update that you can
> specify genfs_context files and seapp_context files...maybe something
> like below will be sufficient:
> 
> Device-specific additions for the policy configuration can be placed
> in a sepolicy.te file (for kernel TE policy rules), a sepolicy.fc file
> (for file_contexts entries), a sepolicy.pc file (for property_contexts
> entries), a sepolicy.genfs_contexts file (for genfs entries), or
> seapp_contexts (for seapp rule entries) under any of the
> target/board/<device>, device/<vendor>/<device>, or
> vendor/<vendor>/<device> directories. These files if present are
> merged into the policy during the build.

Updated.  However, this is starting to get unwieldy.  I was wondering
whether we should switch over to a model where we permit a sepolicy
subdirectory under the device directories that can contain any kind of
policy file (without requiring a sepolicy. prefix on each one since they
will be in a subdirectory).  Just need to decide how we would merge
multiple .te files with the same name, i.e. concatenate/union vs.
replace/override.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
