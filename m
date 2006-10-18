Message-ID: <20061018011433.21838.qmail@web58114.mail.re3.yahoo.com>
Date: Tue, 17 Oct 2006 18:14:33 -0700 (PDT)
From: I_am alone <stupid_kid_me@yahoo.com>
Subject: SID/Context Mapping
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1107203228-1161134073=:17936"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1107203228-1161134073=:17936
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit



Hi All,

        I am new to the SELinux Enviorment. Just learning by doing a Code Review.

1. What i cant figure out is Where does the SID/Security Context Mapping Occur in the SELinux Source Code . I understand its in the security server (According to Flask Architecture doc)......Hows does it happen. (Examlpes of code part would help).... Is it dynamic everytime the System Restarts ? Or is it Assigned when policy is compiled .. (Compiled Object File contains SID-Context Mapped Data.)........(Bec i put sme print statements to see how does the SID Transition occurs at BPRM Loading ....seems like i get the same SID 4 same processes even i reboot the system .... )


It would be helpful if anyone could clarify it


Thanks & Regards



 

 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
--0-1107203228-1161134073=:17936
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br><br>Hi All,<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I am new to the SELinux Enviorment. Just learning by doing a Code Review.<br><br>1. What i cant figure out is Where does the SID/Security Context Mapping Occur in the SELinux Source Code . I understand its in the security server (According to Flask Architecture doc)......Hows does it happen. (Examlpes of code part would help).... Is it dynamic everytime the System Restarts ? Or is it Assigned when policy is compiled .. (Compiled Object File contains SID-Context Mapped Data.)........(Bec i put sme print statements to see how does the SID Transition occurs at BPRM Loading ....seems like i get the same SID 4 same processes even i reboot the system .... )<br><br><br>It would be helpful if anyone could clarify it<br><br><br>Thanks &amp; Regards<br><br><br><br>&nbsp;<br><p>&#32;
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> 

--0-1107203228-1161134073=:17936--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
