Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6N5FZYt019716
 for <selinux@tycho.nsa.gov>; Thu, 23 Jul 2015 01:15:35 -0400
Received: by oihq81 with SMTP id q81so158431972oih.2
 for <selinux@tycho.nsa.gov>; Wed, 22 Jul 2015 22:15:33 -0700 (PDT)
Date: Thu, 23 Jul 2015 00:15:28 -0500
From: Seth Forshee <seth.forshee@canonical.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 0/7] Initial support for user namespace owned mounts
Message-ID: <20150723051528.GA12974@ubuntu-hedt>
References: <CALCETrXA94MBrJ7Dni7RW68Wn3MxcxSmr082hG=haWWncL=feg@mail.gmail.com>
 <55A85041.2070301@schaufler-ca.com>
 <CALCETrUTgfRzzdk3T0wZASSE+KC9S+kmyZbD6-xStS2RRaGiBw@mail.gmail.com>
 <20150721203550.GA80838@ubuntu-hedt>
 <55AEF75F.9010703@schaufler-ca.com>
 <20150722155634.GB124342@ubuntu-hedt>
 <55AFDCA6.10201@schaufler-ca.com>
 <20150722193223.GD124342@ubuntu-hedt>
 <55B02FBD.4040606@schaufler-ca.com>
 <87vbdbd90o.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vbdbd90o.fsf@x220.int.ebiederm.org>
Cc: Serge Hallyn <serge.hallyn@canonical.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, SELinux-NSA <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 22, 2015 at 07:15:19PM -0500, Eric W. Biederman wrote:
> Casey Schaufler <casey@schaufler-ca.com> writes:
> 
> > On 7/22/2015 12:32 PM, Seth Forshee wrote:
> >> On Wed, Jul 22, 2015 at 11:10:46AM -0700, Casey Schaufler wrote:
> >>> On 7/22/2015 8:56 AM, Seth Forshee wrote:
> >>>> On Tue, Jul 21, 2015 at 06:52:31PM -0700, Casey Schaufler wrote:
> >>>>> On 7/21/2015 1:35 PM, Seth Forshee wrote:
> >>>>>> On Thu, Jul 16, 2015 at 05:59:22PM -0700, Andy Lutomirski wrote:
> >>>>>>> On Thu, Jul 16, 2015 at 5:45 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>>>> On 7/16/2015 4:29 PM, Andy Lutomirski wrote:
> >>>>>>>>> I really don't see the benefit of making up extra rules that apply to
> >>>>>>>>> users outside a userns who try to access specifically a filesystem
> >>>>>>>>> with backing store.  They wouldn't make sense for filesystems without
> >>>>>>>>> backing store.
> >>>>>>>> Sure it would. For Smack, it would be the label a file would be
> >>>>>>>> created with, which would be the label of the process creating
> >>>>>>>> the memory based filesystem. For SELinux the rules are more a
> >>>>>>>> touch more sophisticated, but I'm sure that Paul or Stephen could
> >>>>>>>> come up with how to determine it.
> >>>>>>>>
> >>>>>>>> The point, looping all the way back to the beginning, where we
> >>>>>>>> were talking about just ignoring the labels on the filesystem,
> >>>>>>>> is that if you use the same Smack label on the files in the
> >>>>>>>> filesystem as the backing store file has, we'll all be happy.
> >>>>>>>> If that label isn't something user can write to, he won't be
> >>>>>>>> able to write to the mounted objects, either. If there is no
> >>>>>>>> backing store then use the label of the process creating the
> >>>>>>>> filesystem, which will be the user, which will mean everything
> >>>>>>>> will work hunky dory.
> >>>>>>>>
> >>>>>>>> Yes, there's work involved, but I doubt there's a lot. Getting
> >>>>>>>> the label from the backing store or the creating process is
> >>>>>>>> simple enough.
> >>>>>>>>
> >>>>>> So something like the diff below (untested)?
> >>>>> I think that this is close, and quite good for someone
> >>>>> who isn't very familiar with Smack. It's definitely headed
> >>>>> in the right direction.
> >>>>>
> >>>>>> All I'm really doing is setting smk_default as you describe above and
> >>>>>> then using it instead of smk_of_current() in
> >>>>>> smack_inode_alloc_security() and instead of the label from the disk in
> >>>>>> smack_d_instantiate().
> >>>>> Let's say your backing store is a file labeled Rubble.
> >>>>>
> >>>>> mount -o smackfsroot=Rubble,smackfsdef=Rubble ...
> >>>>>
> >>>>> It is completely reasonable for a process labeled Flintstone to
> >>>>> have rwxa access to a file labeled Rubble.
> >>>>>
> >>>>> Smack rule: Flintstone Rubble rwxa
> >>>>>
> >>>>> In the case of writing to an existing Rubble file, what you
> >>>>> have looks fine. What's not so great is that if the Flintstone
> >>>>> process creates a file, it should be labeled Flintstone. Your
> >>>>> use of the smk_default, which is going to violate the principle
> >>>>> of least astonishment, and break the Smack policy as well.
> >>>>>
> >>>>> Let's make a minor change. Instead of using smackfsroot let's
> >>>>> use smackfstransmute and a slightly different access rule:
> >>>>>
> >>>>> mount -o smackfstransmute=Rubble,smackfsdef=Rubble ...
> >>>>>
> >>>>> Smack rule: Flintstone Rubble rwxat
> >>>>>
> >>>>> Now the only change we have to make to the Smack code is
> >>>>> that we don't want to create any files unless either the
> >>>>> process is labeled Rubble or the rule allowing the creation
> >>>>> has the "t" for transmute access. That should ensure that
> >>>>> everything is labeled Rubble. If it isn't, someone has mucked
> >>>>> with the metadata in a detectable way.
> >>>> All right, that kind of makes sense, but I'm still missing some pieces.
> >>>> Questions follow.
> >>>>
> >>>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >>>>>> index 32f598db0b0d..4597420ab933 100644
> >>>>>> --- a/include/linux/fs.h
> >>>>>> +++ b/include/linux/fs.h
> >>>>>> @@ -1486,6 +1486,10 @@ static inline void sb_start_intwrite(struct super_block *sb)
> >>>>>>  	__sb_start_write(sb, SB_FREEZE_FS, true);
> >>>>>>  }
> >>>>>>  
> >>>>>> +static inline bool sb_in_userns(struct super_block *sb)
> >>>>>> +{
> >>>>>> +	return sb->s_user_ns != &init_user_ns;
> >>>>>> +}
> >>>>>>  
> >>>>>>  extern bool inode_owner_or_capable(const struct inode *inode);
> >>>>>>  
> >>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> >>>>>> index a143328f75eb..591fd19294e7 100644
> >>>>>> --- a/security/smack/smack_lsm.c
> >>>>>> +++ b/security/smack/smack_lsm.c
> >>>>>> @@ -255,6 +255,10 @@ static struct smack_known *smk_fetch(const char *name, struct inode *ip,
> >>>>>>  	char *buffer;
> >>>>>>  	struct smack_known *skp = NULL;
> >>>>>>  
> >>>>>> +	/* Should never fetch xattrs from untrusted mounts */
> >>>>>> +	if (WARN_ON(sb_in_userns(ip->i_sb)))
> >>>>>> +		return ERR_PTR(-EPERM);
> >>>>>> +
> >>>>> Go ahead and fetch it, we'll check to make sure it's viable later.
> >>>>>
> >>>>>>  	if (ip->i_op->getxattr == NULL)
> >>>>>>  		return ERR_PTR(-EOPNOTSUPP);
> >>>>>>  
> >>>>>> @@ -656,10 +660,14 @@ static int smack_sb_kern_mount(struct super_block *sb, int flags, void *data)
> >>>>>>  		 */
> >>>>>>  		if (specified)
> >>>>>>  			return -EPERM;
> >>>>>> +
> >>>>>>  		/*
> >>>>>> -		 * Unprivileged mounts get root and default from the caller.
> >>>>>> +		 * User namespace mounts get root and default from the backing
> >>>>>> +		 * store, if there is one. Other unprivileged mounts get them
> >>>>>> +		 * from the caller.
> >>>>>>  		 */
> >>>>>> -		skp = smk_of_current();
> >>>>>> +		skp = (sb_in_userns(sb) && sb->s_bdev) ?
> >>>>>> +			smk_of_inode(sb->s_bdev->bd_inode) : smk_of_current();
> >>>>>>  		sp->smk_root = skp;
> >>>>>>  		sp->smk_default = skp;
> >>>>> 			sp->smk_flags |= SMK_INODE_TRANSMUTE;
> >>>> I assume that you meant skp and not sp here.
> >>> Actually, neither is correct. You want to set SMK_INODE_TRANSMUTE
> >>> in the smk_flags field of the root inode. That's easy:
> >>>
> >>> 			transmute = 1;
> >>>
> >>> and the code after "Initialize the root inode" will take care of it.
> >> Yeah, that's what I've actually done.
> >>
> >>>>>>  	}
> >>>>>> @@ -792,7 +800,12 @@ static int smack_bprm_secureexec(struct linux_binprm *bprm)
> >>>>>>   */
> >>>>>>  static int smack_inode_alloc_security(struct inode *inode)
> >>>>>>  {
> >>>>>> -	struct smack_known *skp = smk_of_current();
> >>>>>> +	struct smack_known *skp;
> >>>>>> +
> >>>>>> +	if (sb_in_userns(inode->i_sb))
> >>>>>> +		skp = ((struct superblock_smack *)(inode->i_sb->s_security))->smk_default;
> >>>>>> +	else
> >>>>>> +		skp = smk_of_current();
> >>>>> This should be left alone.
> >>>>> smack_inode_init_security is where you could disallow access that doesn't
> >>>>> legitimately result in a Rubble label on the file. It's something like
> >>>>>
> >>>>> 	... after the call may = smk_access_entry(...)
> >>>>> 	if (sb_in_userns(inode->i_sb))
> >>>>> 		if (skp != dsp && (may & MAY_TRANSMUTE) == 0)
> >>>>> 			return -EACCES; 
> >>>> I'm not getting how this covers all cases.
> >>>>
> >>>> So we've set the transmute flag on the root inode. Files and directories
> >>>> created in the root directory get the same label, and directories also
> >>>> get the transmute attribute. That's all fine.
> >>>>
> >>>> What about an existing directory in the filesystem that already has a
> >>>> Slate label? I'm not getting what happens with this directory, or for
> >>>> new files created in this directory, which also relates to my other
> >>>> questions below.
> >>>>
> >>>> Also an aside - smk_access_entry looks weird. may is initialized to
> >>>> -ENOENT, and then rule_list is searched for a rule which matches the
> >>>> object and subject labels. Presumably it's possible that no rule could
> >>>> be found, otherwise the prior initialization of may is pointless. If
> >>>> this happens the following code treats it as though it always contains
> >>>> access flags even though it might contain -ENOENT. Nothing bad actually
> >>>> happens with a two's compliement representation of -ENOENT since it will
> >>>> just set a bit that's already set, but it still seems like it should
> >>>> have a may > 0 condition, for clarity if for no other reason.
> >>> My suggested code is just wrong. I wasn't looking at the whole code,
> >>> only the patch, and got myself confused. Apologies.
> >>>
> >>> If we want to go straight for the jugular how about this? I'm assuming
> >>> that inode->i_sb->s_bdev->bd_inode is the inode of the backing store.
> >> Yes.
> >>
> >>> static int smack_inode_permission(struct inode *inode, int mask)
> >>> {
> >>> 	struct smk_audit_info ad;
> >>> 	int no_block = mask & MAY_NOT_BLOCK;
> >>> 	int rc;
> >>>
> >>> 	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> >>> 	/*
> >>> 	 * No permission to check. Existence test. Yup, it's there.
> >>> 	 */
> >>> 	if (mask == 0)
> >>> 		return 0;
> >>>
> >>> +	if (sb_in_userns(inode->i_sb)) &&
> >>> +	    smk_of_inode(inode) != smk_of_inode(inode->i_sb->s_bdev->bd_inode))
> >>> +		return -EACCES;
> >>> +
> >>> 	/* May be droppable after audit */
> >>> 	if (no_block)
> >>> 		return -ECHILD;
> >>> 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_INODE);
> >>> 	smk_ad_setfield_u_fs_inode(&ad, inode);
> >>> 	rc = smk_curacc(smk_of_inode(inode), mask, &ad);
> >>> 	rc = smk_bu_inode(inode, mask, rc);
> >>> 	return rc;
> >>> }
> >> Hmm, okay. I think I've been a little confused all this time about how
> >> you want to handle these unprivileged mounts.
> >
> > Not your problem. I'm not the most consistent of reviewers.
> >
> >> Originally I thought you wanted all objects in the filesystem to get the
> >> same label as the backing store. That's what I tried to implement
> >> originally, i.e. smk_root=smk_default=smk_of_inode(...->bd_inode), then
> >> assign every object (new and existing) smk_default and completely ignore
> >> the labels on disk.
> >
> > I want everything to have the label of the backing store, but
> > I don't want to ignore it if it somehow got something else. Because
> > the only legitimate label for this example is Rubble, I want to
> > reject anything else that appears. If someone builds a filesystem
> > by hand with Slate labels I want it treated "safely".
> >
> >> This is what I currently think you want for user ns mounts:
> >>
> >>  1. smk_root and smk_default are assigned the label of the backing
> >>     device.
> >>  2. s_root is assigned the transmute property.
> >>  3. For existing files:
> >>     a. Files with the same label as the backing device are accessible.
> >>     b. Files with any other label are not accessible.
> >
> > That's right. Accept correct data, reject anything that's not right.
> >
> >> If this is right, there are a couple lingering questions in my mind.
> >>
> >> First, what happens with files created in directories with the same
> >> label as the backing device but without the transmute property set? The
> >> inode for the new file will initially be labeled with smk_of_current(),
> >> but then during d_instantiate it will get smk_default and thus end up
> >> with the label we want. So that seems okay.
> >
> > Yes.
> >
> >> The second is whether files with the SMACK64EXEC attribute is still a
> >> problem. It seems it is, for files with the same label as the backing
> >> store at least. I think we can simply skip the code that reads out this
> >> xattr and sets smk_task for user ns mounts, or else skip assigning the
> >> label to the new task in bprm_set_creds. The latter seems more
> >> consistent with the approach you've suggested for dealing with labels
> >> from disk.
> >
> > Yes, I think that skipping the smk_fetch(XATTR_NAME_SMACKEXEC, ...) in
> > smack_d_instantiate for unprivileged mounts would do the trick.
> >
> >> So I guess all of that seems okay, though perhaps a bit restrictive
> >> given that the user who mounted the filesystem already has full access
> >> to the backing store.
> >
> > In truth, there is no reason to expect that the "user" who did the
> > mount will ever have a Smack label that differs from the label of
> > the backing store. If what we've got here seems restrictive, it's
> > because you've got access from someone other than the "user".
> >
> >> Please let me know whether or not this matches up with what you are
> >> thinking, then I can procede with the implementation.
> >
> > My current mindset is that, if you're going to allow unprivileged
> > mounts of user defined backing stores, this is as safe as we can
> > make it.
> 
> That actually sounds very reasonable to me.  It is essentially what we
> do with uid and gids already.  I presume the smack namespace support
> would when integrated with all of this would allow a set of labels to be
> set.
> 
> Have I missed a part of the conversation you talk about fileystems that
> don't have support for storing labels?  Filesystems like vfat, isofs,
> etc.

As I read the code they should all end up with the superblock's
smk_default label for the objects in RAM, i.e. the label of the backing
store. The same would be true for existing files in a filesystem which
does support storing labels but has no labels on the files.

Seth
