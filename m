From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
Date: Sun, 10 Jun 2007 12:25:43 +1000
Cc: SELinux@tycho.nsa.gov
References: <292705.1594.qm@web53706.mail.re2.yahoo.com>
In-Reply-To: <292705.1594.qm@web53706.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706101225.45161.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 10 June 2007 09:09, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:
>         As fas as I understand (pls correct me if I am wrong) putting an
> app in unconfined domain is only a temporary measure till we have a
> complete policy for that app.  Ideally we should not be allowing any app in
> unconfined domain. Is it not against the SELinux principle
> of "least privelege".

Sometimes the "least privilege" for an application is to allow it to do almost 
anything.

I agree that using minimum privs is a good thing, for example init_t and 
initrc_t could be used to remove SE Linux and Unix access controls in most 
cases but it is possible that an exploit developed for such programs would 
only allow certain access and that if that access was blocked then the 
exploit would not function.  There has been at least one report of a kernel 
exploit not working as unconfined_t!

>          When would we want to run an app in unconfined domain, keeping
> aside the fact that we do not have a completed policy for that app. It is
> something that was introduced for convenience
> in the dekstop case where there are so many apps to be run.
> For an embedded box,  where there are only a few apps, running in
> controlled conditions, is it not adivisable to do away completely with the
> unconfined domain ?

I agree that it makes sense to restrict things as much as possible.  But when 
you have data coming from a trusted source the benefits are minimal.  You 
could of course have a domain that has minimal access to other processes but 
full access to all files on disk.

>     Regding you concern for the contexts not being validated, I understand
> that it might allow certain files to be labelled with contexts which the
> policy does not understand.  Did you mean anything else by validation ?

That's what I mean.

>         The way I take care of this is by labelling the starball with
> setfiles using the same policy (contexts/files/file_contexts file) as the
> complete root filesystem. This is done during the build process. I believe
> setfiles can do the validation against the policy.

That's the right thing to do.  But if you make a mistake or if the file is 
corrupted it would be good to have SE Linux check the context and give you a 
useful error message rather than working and giving you an AVC about 
unlabeled_t later on.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
