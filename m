Message-ID: <41CAE132.3020504@theptrgroup.com>
Date: Thu, 23 Dec 2004 10:16:02 -0500
From: Mike Anderson <mike@theptrgroup.com>
Reply-To: mike@theptrgroup.com
MIME-Version: 1.0
To: SElinux <SELinux@tycho.nsa.gov>
Subject: Starting applications from initrc in a user's context?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings Gurus of Space, Time and SELinux:

  Let me preface by saying that I'm a newbie to SELinux.  <disclaimer done>

  I'm trying to run a series of applications from the init scripts that 
I want to run in separate user contexts. Four separate init scripts all 
run from a master script that runs the user code only if tripwire says 
that the file system is kosher.  The actual launching of the four 
separate scripts is working well.  However, I'm trying to use the runcon 
command to run the applications in the separate user contexts and  I'm 
getting a transition error from the initrc domain to the user domain.  
I've added the

allow initrc_t user1_t:process { transition };

to the user domain .te file as recommended by audit2allow, but this does 
not seem to squelch this error.   As an additional gotcha, the 
applications are actually Java code and are run with the "java 
classname" invokation.

What am I missing?  Or, is there a better way of running the four 
applications in their respective user domains from the init scripts?

Regards,

Mike

-- 

---------------------------------------------------------------
Mike Anderson                    703.585.9384
CTO/Chief Scientist              mike@ThePTRGroup.com
www.ThePTRGroup.com              Embedded, Real-Time Solutions
---------------------------------------------------------------
"Software development is like making a baby. 
 You can't make a baby in one month by impregnating nine women.
 Some things just take time."
             
      -Paraphrased from The Mythical Man Month


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
