From: lonnie@outstep.com
To: SELinux Mailing <SELinux@tycho.nsa.gov>
Subject: Re: setting up new test user domain?
Message-ID: <1008704637.3c1f9c7d11aff@mail.outstep.com>
Date: Tue, 18 Dec 2001 14:43:57 -0500 (EST)
References: <Pine.GSO.4.33.0112181324340.4844-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0112181324340.4844-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Well, I actually have opted to go with Option #2 and have:

1. made a directory domains/test
2. cp domains/users/users.te ../test/testuser.te
3. sed "s/domain/~test_user/g" every.te newevery.te
   mv newevery.te every.te

I should now go and add "test_user_r" to the rbac and then modify the 
testuser.te to reflect test_user_t

I think that these are the correct steps?

Also, is there a small tutorial on doing some of these basic things?

Best Regards,
Lonnie

Quoting Stephen Smalley <sds@tislabs.com>:

> 
> On Tue, 18 Dec 2001 lonnie@outstep.com wrote:
> 
> > Now then, after making the new domain, should I presume that I can
> simply use
> > the standard "adduser" to put a user in that domain, and also use
> the
> > standard "chown" to change the ownership of files to belong to the new
> domain?
> 
> No.  adduser hasn't been modified to be aware of SELinux, and chown
> only
> deals with the Linux user and group attributes.  You need to define an
> entry for the new user and his authorized roles in policy/users and an
> entry for the new role and its authorized domain(s) in policy/rbac. 
> To
> set the security context on the user's home directory, you can use the
> new 'chcon' program.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
