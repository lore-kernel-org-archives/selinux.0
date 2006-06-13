Subject: polyinstantiating /tmp and gdm
From: Janak Desai <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: dwalsh@redhat.com, sgrubb@redhat.com, tmraz@redhat.com, klaus@atsec.com,
        russell@coker.com.au, Valdis.Kletnieks@vt.edu, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 13 Jun 2006 09:47:06 -0400
Message-Id: <1150206426.18955.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Dan,

I have figured out a way to get gdm/X to work with a polyinstantiated
/tmp. In my previous attempts I was bind mounting original /tmp/.X11-unix 
on /instance/.X11-unix and then expecting the socket to be visible
after bind mounting the instance on the original /tmp. Now I understand
why that doesn't work. What we need is to make the original /tmp (or
in our case just the /tmp/.X11-unix) available from alternative location
outside of /tmp before it is mounted over. If you remember, this was 
in Stephen's original design but we removed it because we couldn't find
any use for it. Now we have :-). This is still a very specific use, so
I am going to special case it with instance.init script and NOT bring 
back the "original" directory code that was present in the earlier 
incarnation of the pam_namespace. The only change to pam_namespace module
will be to always execute the instance.init script as opposed to only at
the time of the instance creation. 

I have to finish some lspp stuff today, but I will try and send out an
updated patch with modified pam_namespace, instance.init and man pages
by tomorrow.

Thanks.

-Janak


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
