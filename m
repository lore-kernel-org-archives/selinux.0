Subject: Re: [PATCH 12/15] [src-policy] semodule: edit module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux@tycho.nsa.gov, csellers@tresys.com, kmacmillan@tresys.com,
        jwcart2@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <1264543701-20638-13-git-send-email-ccase@tresys.com>
References: <1264543701-20638-1-git-send-email-ccase@tresys.com>
	 <1264543701-20638-2-git-send-email-ccase@tresys.com>
	 <1264543701-20638-3-git-send-email-ccase@tresys.com>
	 <1264543701-20638-4-git-send-email-ccase@tresys.com>
	 <1264543701-20638-5-git-send-email-ccase@tresys.com>
	 <1264543701-20638-6-git-send-email-ccase@tresys.com>
	 <1264543701-20638-7-git-send-email-ccase@tresys.com>
	 <1264543701-20638-8-git-send-email-ccase@tresys.com>
	 <1264543701-20638-9-git-send-email-ccase@tresys.com>
	 <1264543701-20638-10-git-send-email-ccase@tresys.com>
	 <1264543701-20638-11-git-send-email-ccase@tresys.com>
	 <1264543701-20638-12-git-send-email-ccase@tresys.com>
	 <1264543701-20638-13-git-send-email-ccase@tresys.com>
Content-Type: text/plain
Date: Wed, 27 Jan 2010 15:21:26 -0500
Message-Id: <1264623686.17372.87.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 17:08 -0500, Caleb Case wrote:
> In order to ease the process of modifying an installed module, this
> provides the -E,--edit option to semodule. It will retrieve the
> specified module, open it in the default editor, and then reinstall the
> module if editing completes successfully.
> 
> * Editor to be executed is discovered from the EDITOR environment
>   variable.
> 
> * Transaction locks are held for the duration of the editing.
> 
> * If -E is specified multiple times, then the editor will be
>   called on each one, consecutively (editing stops on a particular
>   module when the editor exits).
> 
> * If the editor exits with a non-zero status, then the transaction
>   will be aborted.
> 
> * If the editor exits without making any changes to the file (as
>   determined from the time stamp), then the transaction will be not be
>   committed unless another action requires it to be.
> 
> * The editor will be executed in the users SELinux context (as
>   determined by getprevcon)
> 
> Example:
> 
> # export EDITOR=vim
> # semodule -E alsa
> <edit alsa module>
> <after quiting editor module is installed>
> ---

I'm concerned that this is over-engineering.  Why not just provide -g
(aka --checkout) and -i (aka --commit or --checkin), and let the editing
happen entirely outside of the infrastructure.  Do we really want to
allow the caller to hold the transaction locks indefinitely?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
