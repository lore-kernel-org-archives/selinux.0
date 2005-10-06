Message-ID: <4345915C.7050305@cornell.edu>
Date: Thu, 06 Oct 2005 17:04:28 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Gaurav Poothia <gpoothia@cs.sunysb.edu>
CC: SELinux@tycho.nsa.gov
Subject: Re: Newbie questions
References: <Pine.GSO.4.53.0510061416520.10856@compserv1>
In-Reply-To: <Pine.GSO.4.53.0510061416520.10856@compserv1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Q1. Is the idea here for SELinux to create specialized domains for all
> possible desktop apps (on the server side it seems the plan is to
> eventually confine all daemons)?
I think that's what the plan is/was...whether this is actually possible 
remains to be discovered. Desktop apps are very difficult to deal with, 
since they tend to be highly complex, and interact in complicated ways.
>   If not then any SELinux unaware app on
> exec will run within  Mozilla domain if called form within the browser
> (viewers/players/editors)?
>   
The app does not have to be SELinux aware - this is done automatically 
for the app, based on policy. Applications which do not have a 
transition defined in policy from mozilla to a different type continue 
to run as mozilla (and usually get lots of denials).
> What about invocation from shell...will it then run within user_t domain?
>   
That depends on whether or not transitions are defined from user_t to a 
different domain upon executing the application. If no policy has been 
written for an application, for example, it would run as user_t (and as 
$1_mozilla_t in the case above).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
