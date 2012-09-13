Message-ID: <1347564198.28276.14.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: Security hooks for rpm
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Elena Reshetova <elena.reshetova@gmail.com>, SELinux@tycho.nsa.gov,
        Steve Lawrence <slawrence@tresys.com>
Date: Thu, 13 Sep 2012 15:23:18 -0400
In-Reply-To: <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
References: 
	<CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	 <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-09-10 at 10:44 -0400, Stephen Smalley wrote:
> On Mon, 2012-09-10 at 11:07 +0300, Elena Reshetova wrote:
> > Hi,
> > 
> > As we agreed during the LSS Iet's try to define a unified set of
> > security hooks for rpm.
> > I have promised to post the set of hooks that we are proposing. I
> > think we can try first to agree on the hooks and they arguments and
> > then agree about their place. I can make the needed adjustments on the
> > actual code.
> > 
> > Also I have been thinking that since we are talking more and more
> > about stackable LSMs, then security plug-in interface for rpm should
> > support multiple security plug-ins in case package comes with
> > configurations for a number of LSMs (also things like IMA/EVM setup
> > can be moved to a separate plug-in).
> > What do you think about it?
> 
> I'd agree - I was thinking however that rpm already supports multiple
> plugins.  Is that not the case?  Is there a reason that this needs to
> specifically be security hooks vs. just general plugin hooks?
> 
Multiple collection plugins are supported.

> > All current hooks return rpmRC error code, which is RPMRC_OK, if no
> > errors are detected and RPMRC_FAIL, if failure is detected and
> > installation must be aborted.
> > 
> > And here are the actual hooks:
> > 
> > 1. rpmRC SECURITYHOOK_INIT_FUNC(rpmts ts, const char *opts)
> 
> I see that our init func takes a const char *name argument as well; I
> don't know offhand whether it is truly required (Steve or Jim?).
> 

This is the name of the collection. It is required so that all the
members of a collection can be grouped together. This is needed because
all SELinux policy must be installed before applications and files that
the policy is for.

> > 7. rpmRC SECURITYHOOK_SCRIPT_EXEC_FUNC(ARGV_const_t argv)
> 
> It looks like our rpm_execcon() hook takes more arguments, but they
> aren't truly unique or used, so this seems reasonable to me as a
> simplified interface.
> 

rpm_execcon() is not a part of the collection plugin support. I guess
the plan would be to remove all of the SELinux support built in (such as
the %sepolicy section)?

> > 8. rpmRC SECURITYHOOK_FSM_OPENED_FUNC(const char* dirName, const char* baseName)
> > 
> > This is first of the three file hooks that are needed by the security
> > plugin to perform an operation of a certain file from the package.
> > This hook is called before the file is read from the archive. The
> > dirName and baseName allow to reconstruct the path of the file to be
> > place to the filesystem.
> > 
> > 9. rpmRC SECURITYHOOK_FSM_UPDATED_FUNC(const struct stat * st, char
> > *buf, size_t len)
> > 
> > This is the second of the file hooks. It is called a number of times
> > depending on the file length every time a new chunk of file is read
> > from the archive to the buffer. The actual buffer and its length is
> > provided in the parameters.
> > 
> > 10. rpmRC SECURITYHOOK_FSM_CLOSED_FUNC(int rpmrc)
> > 
> > The last file hook allows the plugin to finish the file processing. It
> > is called once per each file from the package and after the file has
> > been placed to the filesystem. Can be used to label the file.
> 
> I'm not clear on how you can label the file if the only input to this
> hook is the rpmrc value?  We need the selabel handle, file path, and
> file mode as inputs (see fsmSetSELabel, called by fsmCommit).  That is
> also called by fsmMkdirs() to ensure proper labeling of directories not
> explicitly included in the package but part of that path to a given
> file.
> 

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
