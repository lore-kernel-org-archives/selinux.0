Date: Sun, 10 Jun 2007 00:09:04 +0100 (BST)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200706091347.50549.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1116765489-1181430544=:1594"
Message-ID: <292705.1594.qm@web53706.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1116765489-1181430544=:1594
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Russel,
                Thanx for your inputs. 
    
        As fas as I understand (pls correct me if I am wrong) putting an app in unconfined domain is only a temporary measure till we have a 
complete policy for that app.  Ideally we should not be allowing any 
app in unconfined domain. Is it not against the SELinux principle
of "least privelege". 
            
         When would we want to run an app in unconfined domain, keeping aside the fact that we do not have a completed policy
for that app. It is something that was introduced for convenience 
in the dekstop case where there are so many apps to be run. 
For an embedded box,  where there are only a few apps, running in controlled conditions, is it not adivisable to do away completely 
with the unconfined domain ?

    Regding you concern for the contexts not being validated, I understand that it might allow certain files to be labelled with contexts which the policy does not understand.  Did you mean anything else by validation ?

        The way I take care of this is by labelling the starball with setfiles using the same policy (contexts/files/file_contexts file) as the complete root filesystem. This is done during the build process. I believe setfiles can do the validation against the policy. 


Thanx,
Tomar


Russell Coker <russell@coker.com.au> wrote: On Saturday 09 June 2007 01:04, Nagendra Tomar  wrote:
> Russell Coker  wrote:Why do you need to extract many
> security contexts from a tar file in a rc script?
>
> I need to add files from an archive stored on flash to my RFS. This has to
> happen during boot. I have resolved this issue by extracting the required
> archives, before the SELinux policy is loaded, i.e from the initramfs' init
> script and not from the rc script as I mentioned before.

If you are going to run the script in question without confinement, then why 
not use an unconfined domain after the policy is loaded instead of doing it 
before policy load?

Setting contexts before the policy load means that the contexts can't be 
validated, and I can't think of any benefits to doing it in the initramfs.





-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


       
---------------------------------
 Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for your freeaccount today.
--0-1116765489-1181430544=:1594
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Russel,<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;  Thanx for your inputs. <br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; As fas as I understand (pls correct me if I am wrong) putting an app in unconfined domain is only a temporary measure till we have a <br>complete policy for that app.&nbsp; Ideally we should not be allowing any <br>app in unconfined domain. Is it not against the SELinux principle<br>of "least privelege". <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;  &nbsp;&nbsp;  <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;  When would we want to run an app in unconfined domain, keeping aside the fact that we do not have a completed policy<br>for that app. It is something that was introduced for convenience <br>in the dekstop case where there are so many apps to be run. <br>For an embedded box,&nbsp; where there are only a few apps, running in controlled conditions, is it not adivisable to do away completely <br>with the unconfined domain
 ?<br><br>&nbsp;&nbsp;&nbsp; Regding you concern for the contexts not being validated, I understand that it might allow certain files to be labelled with contexts which the policy does not understand.&nbsp; Did you mean anything else by validation ?<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; The way I take care of this is by labelling the starball with setfiles using the same policy (contexts/files/file_contexts file) as the complete root filesystem. This is done during the build process. I believe setfiles can do the validation against the policy. <br><br><br>Thanx,<br>Tomar<br><br><br><b><i>Russell Coker &lt;russell@coker.com.au&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> On Saturday 09 June 2007 01:04, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:<br>&gt; Russell Coker <russell@coker.com.au> wrote:Why do you need to extract many<br>&gt; security contexts from a tar file in a rc
 script?<br>&gt;<br>&gt; I need to add files from an archive stored on flash to my RFS. This has to<br>&gt; happen during boot. I have resolved this issue by extracting the required<br>&gt; archives, before the SELinux policy is loaded, i.e from the initramfs' init<br>&gt; script and not from the rc script as I mentioned before.<br><br>If you are going to run the script in question without confinement, then why <br>not use an unconfined domain after the policy is loaded instead of doing it <br>before policy load?<br><br>Setting contexts before the policy load means that the contexts can't be <br>validated, and I can't think of any benefits to doing it in the initramfs.<br><br><br><br><br><br>-- <br>russell@coker.com.au<br>http://etbe.coker.com.au/          My Blog<br><br>http://www.coker.com.au/sponsorship.html Sponsoring Free Software development<br><br>--<br>This message was distributed to subscribers of the selinux mailing list.<br>If you no longer wish to subscribe,
 send mail to majordomo@tycho.nsa.gov with<br>the words "unsubscribe selinux" without quotes as the message.<br></russell@coker.com.au></tomer_iisc@yahoo.com></blockquote><br><p>&#32;


      <hr size=1> 
Yahoo! Mail is the world's favourite email. Don't settle for less, <a
href="http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html">sign up for your free
account today</a>.
--0-1116765489-1181430544=:1594--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
