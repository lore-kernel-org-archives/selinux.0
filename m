Message-ID: <20061121043021.34260.qmail@web58112.mail.re3.yahoo.com>
Date: Mon, 20 Nov 2006 20:30:21 -0800 (PST)
From: I_am alone <stupid_kid_me@yahoo.com>
Subject: Task SID 's
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-546926885-1164083421=:30720"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-546926885-1164083421=:30720
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Hi 

  I am new to SELinux. I am planning to learn it by doing a Code Review. Currently I am Confused of Task SID Assignments & Binary Program SID to Task SID Converstions.

1. How does SID's are assigned to the init Task in the SELinux Code . Which code part handles that .


2. I found that binary program SID's assigned changes in to the Task SID's when they are loaded. Which code part in SELinux handles this part.

That is when a Binary Program is loaded it is assigned SID's and once it is loaded it becomes as task. How does the bprm_security_structure SID values are transfered in to the  task_security_structure_sid Values ...


If anyone can guide me on these it would be really helpful for me to learn.

Thanks & Regards
Pragash.J

 
---------------------------------
Sponsored Link

   Don't quit your job  - take classes online and earn your degree in 1 year. Start Today
--0-546926885-1164083421=:30720
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>Hi <br><br>&nbsp; I am new to SELinux. I am planning to learn it by doing a Code Review. Currently I am Confused of Task SID Assignments &amp; Binary Program SID to Task SID Converstions.<br><br>1. How does SID's are assigned to the init Task in the SELinux Code . Which code part handles that .<br><br><br>2. I found that binary program SID's assigned changes in to the Task SID's when they are loaded. Which code part in SELinux handles this part.<br><br>That is when a Binary Program is loaded it is assigned SID's and once it is loaded it becomes as task. How does the bprm_security_structure SID values are transfered in to the&nbsp; task_security_structure_sid Values ...<br><br><br>If anyone can guide me on these it would be really helpful for me to learn.<br><br>Thanks &amp; Regards<br>Pragash.J<br><p>&#32;

<font color="666666"><font size="2"><hr size=1>Sponsored Link</font></font><br><br>   
<a href="http://www.classesusa.com/clickcount.cfm?id=607556&goto=http%3A%2F%2Fwww.classesusa.com%2Ffeaturedschools%2Fonlinedegreesmp%2Fform-dyn1.html%3Fsplovr%3D607555">Don't quit your job</a>  - take classes online and <a href="http://www.classesusa.com/clickcount.cfm?id=607556&goto=http%3A%2F%2Fwww.classesusa.com%2Ffeaturedschools%2Fonlinedegreesmp%2Fform-dyn1.html%3Fsplovr%3D607555">earn your degree in 1 year. Start Today</a>
--0-546926885-1164083421=:30720--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
