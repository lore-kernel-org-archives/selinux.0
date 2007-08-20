Subject: Re: why there is a only_changed_user in restorecon?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Liu Jian <gjk.liu@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <8c2dc7030708200117w26d86872kff135e63a1ec0548@mail.gmail.com>
References: <8c2dc7030708200117w26d86872kff135e63a1ec0548@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 20 Aug 2007 07:48:21 -0400
Message-Id: <1187610501.24940.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-20 at 16:17 +0800, Liu Jian wrote:
> I wonder why there is special check on the only_changed_user in the
> restorecon. After
> 'chcon -u systerm_u /home/user/file', the secruity label of the file
> is changed from 'user_u:object_r:user_home_t' to
> 'system_u:object_r:user_home_t'. But 'restorecon /home/user/file' can
> not restore its label to original.
> 
> 'man restorecon', you can see:
> 
> ...
> 
> -F Force reset of context to match file_context for customizable
> files, or the user section, if it has changed.
> ...
> 
> Yes, we can 'restorcecon -F /home/user/file' get the original label
> 
> 
> But why there is special check on the only_changed_user? any reason...

As I recall, it was to avoid extraneous relabeling of files.  New files
inherit the SELinux user of the creating process, and thus may not
correspond with the initial state defined in the file_contexts
specification.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
