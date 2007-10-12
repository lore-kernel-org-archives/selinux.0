Date: Thu, 11 Oct 2007 22:31:05 -0700 (PDT)
From: run zhang <zhang4run@yahoo.com>
Subject: cannot see boolean variable in /selinux/booleans
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1240250435-1192167065=:98070"
Message-ID: <502597.98070.qm@web63011.mail.re1.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1240250435-1192167065=:98070
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I declear a bool in a simple SELinux policy file (two types and one role). The binary policy is compiled and loaded and runs well. The dmesg shows that "1 bools" in the policy loaded when starts. However, I cannot see the bool variable in /selinux/booleans thus cannot chage its value during runtime . I think some steps are missed. The bool is defined as: 
...
type base_t;
type test_t;
bool test_verify false;

if (test_verify) {
allow base_t test_t: file *;
allow base_t test_t: dir *; 
}
else {
allow base_t test_t: file { getattr };
allow base_t test_t: dir { getattr read search }; }
...

The msg with getsebool: 
getsebool:  Unable to get boolean names:  Success
The msg with setsebool: 
Could not change active booleans: Invalid boolean                                                            
Could not change policy booleans

Thanks!

       
---------------------------------
Fussy? Opinionated? Impossible to please? Perfect.  Join Yahoo!'s user panel and lay it on us.
--0-1240250435-1192167065=:98070
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I declear a bool in a simple SELinux policy file (two types and one role). The binary policy is compiled and loaded and runs well. The dmesg shows that "1 bools" in the policy loaded when starts. However, I cannot see the bool variable in /selinux/booleans thus cannot chage its value during runtime . I think some steps are missed. The bool is defined as: <br>...<br>type base_t;<br>type test_t;<br>bool test_verify false;<br><br>if (test_verify) {<br>allow base_t test_t: file *;<br>allow base_t test_t: dir *; <br>}<br>else {<br>allow base_t test_t: file { getattr };<br>allow base_t test_t: dir { getattr read search }; }<br>...<br><br>The msg with getsebool: <br>getsebool:&nbsp; Unable to get boolean names:&nbsp; Success<br>The msg with setsebool: <br>Could not change active booleans: Invalid
 boolean&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>Could not change policy booleans<br><br>Thanks!<br><p>&#32;
      <hr size=1>Fussy? Opinionated? Impossible to please? Perfect.  <a href="http://us.rd.yahoo.com/evt=48516/*http://surveylink.yahoo.com/gmrs/yahoo_panel_invite.asp?a=7 ">Join Yahoo!'s user panel</a> and lay it on us.

--0-1240250435-1192167065=:98070--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
