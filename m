Date: Fri, 8 Jun 2007 16:04:34 +0100 (BST)
From: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
To: russell@coker.com.au
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200706081013.23796.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1100094070-1181315074=:5113"
Message-ID: <140001.5113.qm@web53711.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1100094070-1181315074=:5113
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Russell Coker <russell@coker.com.au> wrote:Why do you need to extract many security contexts from a tar file in a rc 
script?

I need to add files from an archive stored on flash to my RFS. This has to happen during boot.
       I have resolved this issue by extracting the required archives, before the SELinux policy is loaded, i.e from the initramfs' init script and not from the rc script as I mentioned before.

Thanx for your comments.

- Tomar
-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog
-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development
http://www.coker.com.au/sponsorship.html Sponsoring Free Software development



       
---------------------------------
 Yahoo! Mail is the world's favourite email. Don't settle for less, sign up for your freeaccount today.
--0-1100094070-1181315074=:5113
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br><b><i>Russell Coker &lt;russell@coker.com.au&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"><tomer_iisc@yahoo.com>Why do you need to extract many security contexts from a tar file in a rc <br>script?<br><br>I need to add files from an archive stored on flash to my RFS. This has to happen during boot.<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; I have resolved this issue by extracting the required archives, before the SELinux policy is loaded, i.e from the initramfs' init script and not from the rc script as I mentioned before.<br><br>Thanx for your comments.<br><br>- Tomar<br>-- <br>russell@coker.com.au<br>http://etbe.coker.com.au/          My Blog<br></tomer_iisc@yahoo.com>-- <br>russell@coker.com.au<br>http://etbe.coker.com.au/          My Blog<br><br>http://www.coker.com.au/sponsorship.html Sponsoring Free Software
 development<br><tomer_iisc@yahoo.com>http://www.coker.com.au/sponsorship.html Sponsoring Free Software development<br><br></tomer_iisc@yahoo.com></blockquote><br><p>&#32;


      <hr size=1> 
Yahoo! Mail is the world's favourite email. Don't settle for less, <a
href="http://uk.rd.yahoo.com/evt=44106/*http://uk.docs.yahoo.com/mail/winter07.html">sign up for your free
account today</a>.
--0-1100094070-1181315074=:5113--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
