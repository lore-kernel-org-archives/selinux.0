MIME-Version: 1.0
In-Reply-To: <1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
References: <CALrft9-GWLKNZU=4yDBNx6hp=HJbh9qCUEntvYypz3F63Sd==w@mail.gmail.com>
	<1347288243.9456.53.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 11 Sep 2012 14:56:40 +0300
Message-ID: <CALrft98Np4v5Lyhzy+_NEJkf9aqkC60PzMT4fFoYcPgohzyJqQ@mail.gmail.com>
Subject: Re: Security hooks for rpm
From: Elena Reshetova <elena.reshetova@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov, Steve Lawrence <slawrence@tresys.com>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Mon, Sep 10, 2012 at 5:44 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2012-09-10 at 11:07 +0300, Elena Reshetova wrote:
>> Also I have been thinking that since we are talking more and more
>> about stackable LSMs, then security plug-in interface for rpm should
>> support multiple security plug-ins in case package comes with
>> configurations for a number of LSMs (also things like IMA/EVM setup
>> can be moved to a separate plug-in).
>> What do you think about it?
>
> I'd agree - I was thinking however that rpm already supports multiple
> plugins.  Is that not the case?  Is there a reason that this needs to
> specifically be security hooks vs. just general plugin hooks?

I agree that it is better to have one plugin interface for rpm that
can be used either for security or other purposes. However my current
understanding is that the only interface for plugins that rpm has is a
"collection plugin". I don't have anything against it, but do we need
that notion for set of generic security rpm hooks? I don't think every
plugin needs to be aware about what is a  "collection" and how to
handle it. I would prefer a simpler approach when a set of hooks is
defined and then called at different stages of the rpm execution.

Another issue is that I would like to be able to mandate the presence
of a plugin in a system in some cases. For example for our platform, I
would like to tell that if loading of our security plugin fails, then
installation must be aborted. I think current plugin interface doesn't
provide a way to do it either.

>> 10. rpmRC SECURITYHOOK_FSM_CLOSED_FUNC(int rpmrc)
>>
>> The last file hook allows the plugin to finish the file processing. It
>> is called once per each file from the package and after the file has
>> been placed to the filesystem. Can be used to label the file.
>
> I'm not clear on how you can label the file if the only input to this
> hook is the rpmrc value?  We need the selabel handle, file path, and
> file mode as inputs (see fsmSetSELabel, called by fsmCommit).  That is
> also called by fsmMkdirs() to ensure proper labeling of directories not
> explicitly included in the package but part of that path to a given
> file.

Yes, you are right, this hook needs changing. The reason why initially
we didn't need more arguments is that the plugin remembered needed
info from the FSM_OPENED hook (like path for example) and then in
FSM_CLOSE used this info. However, I have just changed things a bit
and I think now the interface can be smth like:

rpmRC SECURITYHOOK_FSM_CLOSED_FUNC(const char* dirName, const char*
baseName, mode_t mode, int rpmrc)

I have noticed that SELinux uses fsm->path directly, do you prefer to
have that one passed to the hook or dirName + baseName is ok?

About the selabel handle: I would prefer to keep any plugin internal
data outside of actual rpm. It helps to keep the rpm and plugin
independent with only dependency on the actual hooks. The way we
handle it in our plugin is that this info is preserved in the plugin
state while package processing is going. Would any such approach be
acceptable for selinux?

Another option to go about it would be to define a handle for each
plugin's data as simple void pointer and then pass this handle to the
plugin in everyhook. Internally plugin can store any stuct behind this
including any needed handles. But I think this won't be much different
for the plugin than storing this by itself.

And fsmMkdirs() is actually a good point! I am wondering what would be
the proper way to handle this part. I think it might make sense to
define a new hook just for this purpose, because this hook would be
called only once per package versus the FSM_CLOSED that is called once
per every file in the package. The interface can be similar to CLOSED
hook:

rpmRC SECURITYHOOK_FSM_MAKE_DIR_FUNC(const char* dirName, const char*
baseName, mode_t mode)

What do you think?

Best Regards,
Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
