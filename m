Date: Sat, 14 Feb 2004 00:09:22 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: SELinux@tycho.nsa.gov
Subject: Of applications and separating configuration systems
Message-ID: <20040214000922.GA1083@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
  Having started looking at SELinux a thought struck me.
As a general matter of practice wouldn't it be better for desktop
like applications to have the preference editing done by a separate
program (binary) whose only job is to edit those preferences and
configurations.

The thought is bought about by hearing of some of the viruses/worms that
have happened where a virus has disabled some of the other security
features in an app.    If the main app that was exposed to user
data couldn't alter its own preferences file then this risk
would be greatly reduced.

It strikes me that normal users of a system might want to have multiple
contexts to them within a windowing system; for example with seperate
permissions for normal stuff, a web browser, the web browser they use
for confidential stuff, and building things they downloaded.
Is it easy to set such a system up?  What about allowing normal users
to see the policy violations that are causing their individual programs
are making?

Dave

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
