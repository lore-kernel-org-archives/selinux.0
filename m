Date: Fri, 8 Jun 2007 00:02:10 +0100 (BST)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Fwd: "star -xattr" in SELinux enabled system
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-387842203-1181257330=:82487"
Message-ID: <2433.82487.qm@web53709.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-387842203-1181257330=:82487
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Resending after subscribing to the SELinux mailing list

Nagendra Tomar <tomer_iisc@yahoo.com> wrote: Date: Thu, 7 Jun 2007 23:47:40 +0100 (BST)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: "star -xattr" in SELinux enabled system
To: SELinux@tycho.nsa.gov

 When I try to unpack a star tarball which was packed with the xattr option (to retain the selinux file contexts), I get a lot of "denied" errors. These errors  are not unexpected, as star tries to set the extended attributes of each of the component file in the tarball as it extracts them.
    Since, I've not given the relabelfrom/relabelto permissions for those combinations of file contexts, the errors are expected. Apart from the relabel from/to errors, there are also mkdir/create file errors as start tries to create directories and files inside directories with contexts which the star process'  domain has not been authorized to. Nothing wrong in this, as this is what SELinux is supposed to do.
 I'm running a modified ref policy where my goal is to be very restrictive in what I allow.
    My question is:
Can it be inferred that star (or tar for that matter)  is best avoided if we want to make a very  secure/restrictive SELinux policy ? O/w the policy has to be modified for any star tarball that we may want to extract. 
    I'm running star from the rc scripts (with initrc_t) domain. Everytime I allow initrc_t domain some create/write/relabelto/relabelfrom permission, I feel that I am allowing more than what I should. Will it be a good idea to assign a different domain to the star process and allow that domain all these permissions (the problem of future star tarballs failing to extract is still there though)

Regds,
Tomar


          

---------------------------------
  Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for your free account today.

       
---------------------------------
 Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for your freeaccount today.
--0-387842203-1181257330=:82487
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Resending after subscribing to the SELinux mailing list<br><br><b><i>Nagendra Tomar &lt;tomer_iisc@yahoo.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Date: Thu, 7 Jun 2007 23:47:40 +0100 (BST)<br>From: Nagendra Tomar &lt;tomer_iisc@yahoo.com&gt;<br>Subject: "star -xattr" in SELinux enabled system<br>To: SELinux@tycho.nsa.gov<br><br> When I try to unpack a star tarball which was packed with the xattr option (to retain the selinux file contexts), I get a lot of "denied" errors. These errors&nbsp; are not unexpected, as star tries to set the extended attributes of each of the component file in the tarball as it extracts them.<br>&nbsp;&nbsp;&nbsp; Since, I've not given the relabelfrom/relabelto permissions for those combinations of file contexts, the errors are expected. Apart from the relabel from/to errors, there are also mkdir/create file errors as start tries to create directories
 and files inside directories with contexts which the star process'&nbsp; domain has not been authorized to. Nothing wrong in this, as this is what SELinux is supposed to do.<br>&nbsp;I'm running a modified ref policy where my goal is to be very restrictive in what I allow.<br>&nbsp;&nbsp;&nbsp; My question is:<br>Can it be inferred that star (or tar for that matter)&nbsp; is best avoided if we want to make a very  secure/restrictive SELinux policy ? O/w the policy has to be modified for any star tarball that we may want to extract. <br>&nbsp;&nbsp;&nbsp; I'm running star from the rc scripts (with initrc_t) domain. Everytime I allow initrc_t domain some create/write/relabelto/relabelfrom permission, I feel that I am allowing more than what I should. Will it be a good idea to assign a different domain to the star process and allow that domain all these permissions (the problem of future star tarballs failing to extract is still there
 though)<br><br>Regds,<br>Tomar<br><br><br><div>          </div><hr size="1">  Yahoo! Mail is the world's favourite email. Don't settle for less, <a href="http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html">sign up for your free account today</a>.</blockquote><br><p>&#32;


      <hr size=1> 
Yahoo! Mail is the world's favourite email. Don't settle for less, <a
href="http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html">sign up for your free
account today</a>.
--0-387842203-1181257330=:82487--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
