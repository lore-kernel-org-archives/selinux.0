Date: Sun, 10 Jun 2007 05:29:01 +0100 (BST)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200706101225.45161.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-218964511-1181449741=:44086"
Message-ID: <727001.44086.qm@web53702.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-218964511-1181449741=:44086
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Russell Coker <russell@coker.com.au> wrote: On Sunday 10 June 2007 09:09, Nagendra Tomar  wrote:
>         As fas as I understand (pls correct me if I am wrong) putting an
> app in unconfined domain is only a temporary measure till we have a
> complete policy for that app.  Ideally we should not be allowing any app in
> unconfined domain. Is it not against the SELinux principle
> of "least privelege".

Sometimes the "least privilege" for an application is to allow it to do almost 
anything.

???? Can you pls explain this ?


I agree that using minimum privs is a good thing, for example init_t and 
initrc_t could be used to remove SE Linux and Unix access controls in most 
cases but it is possible that an exploit developed for such programs would 
only allow certain access and that if that access was blocked then the 
exploit would not function.  There has been at least one report of a kernel 
exploit not working as unconfined_t!

Thanx for the pointer.

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

Is that not as bad as it can get ? If a domain is allowed to do anything with all files on the  filesystem, it can craft a file with the right context which can then lead it to other domains (on execution). I understand that SELinux can disallow this by blocking the exec rights for the unconfined  domain (for that particular context),  but will it not be  more prone to errors to ensure that for all possible contexts.


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


 		
---------------------------------
 What kind of emailer are you? Find out today - get a free analysis of your email personality. Take the quiz at the Yahoo! Mail Championship.
--0-218964511-1181449741=:44086
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br><b><i>Russell Coker &lt;russell@coker.com.au&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Sunday 10 June 2007 09:09, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:<br>&gt;         As fas as I understand (pls correct me if I am wrong) putting an<br>&gt; app in unconfined domain is only a temporary measure till we have a<br>&gt; complete policy for that app.  Ideally we should not be allowing any app in<br>&gt; unconfined domain. Is it not against the SELinux principle<br>&gt; of "least privelege".<br><br>Sometimes the "least privilege" for an application is to allow it to do almost <br>anything.<br><br>???? Can you pls explain this ?<br><br><br>I agree that using minimum privs is a good thing, for example init_t and <br>initrc_t could be used to remove SE Linux and Unix access controls in most <br>cases but it is possible that an exploit developed for such programs would <br>only
 allow certain access and that if that access was blocked then the <br>exploit would not function.  There has been at least one report of a kernel <br>exploit not working as unconfined_t!<br><br>Thanx for the pointer.<br><br>&gt;          When would we want to run an app in unconfined domain, keeping<br>&gt; aside the fact that we do not have a completed policy for that app. It is<br>&gt; something that was introduced for convenience<br>&gt; in the dekstop case where there are so many apps to be run.<br>&gt; For an embedded box,  where there are only a few apps, running in<br>&gt; controlled conditions, is it not adivisable to do away completely with the<br>&gt; unconfined domain ?<br><br>I agree that it makes sense to restrict things as much as possible.  But when <br>you have data coming from a trusted source the benefits are minimal.  You <br>could of course have a domain that has minimal access to other processes but <br>full access to all files on disk.<br><br>Is that
 not as bad as it can get ? If a domain is allowed to do anything with all files on the&nbsp; filesystem, it can craft a file with the right context which can then lead it to other domains (on execution). I understand that SELinux can disallow this by blocking the exec rights for the unconfined&nbsp; domain (for that particular context),&nbsp; but will it not be  more prone to errors to ensure that for all possible contexts.<br><br><br>&gt;     Regding you concern for the contexts not being validated, I understand<br>&gt; that it might allow certain files to be labelled with contexts which the<br>&gt; policy does not understand.  Did you mean anything else by validation ?<br><br>That's what I mean.<br><br>&gt;         The way I take care of this is by labelling the starball with<br>&gt; setfiles using the same policy (contexts/files/file_contexts file) as the<br>&gt; complete root filesystem. This is done during the build process. I believe<br>&gt; setfiles can do the
 validation against the policy.<br><br>That's the right thing to do.  But if you make a mistake or if the file is <br>corrupted it would be good to have SE Linux check the context and give you a <br>useful error message rather than working and giving you an AVC about <br>unlabeled_t later on.<br><br>-- <br>russell@coker.com.au<br>http://etbe.coker.com.au/          My Blog<br><br>http://www.coker.com.au/sponsorship.html Sponsoring Free Software development<br></tomer_iisc@yahoo.com></blockquote><br><p>&#32;
		<hr size=1> 
What kind of emailer are you? Find out today - get a free analysis of your email personality. Take the quiz at the <a href="http://uk.rd.yahoo.com/mail/uk/taglines/default/championships/quiz/*http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk/">Yahoo! Mail Championship</a>.
--0-218964511-1181449741=:44086--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
