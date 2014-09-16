Message-ID: <5418300A.4060802@tycho.nsa.gov>
Date: Tue, 16 Sep 2014 08:41:46 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Avijit Das <avijitnsec@live.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Few issues we are facing when we are enabling selinux
References: <COL127-W2961A74296F76BECD4CC63B1C90@phx.gbl>
In-Reply-To: <COL127-W2961A74296F76BECD4CC63B1C90@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/15/2014 10:53 PM, Avijit Das wrote:
> Hi,
> We are facing couple of issues when we are enabling selinux. We are trying to enabling it in android device.
> 1. If we trying to set some context to any symblink, it is not able to set the context. Earlier we are able to set context in symblink. Is there any new change which made it disable.2. Also if enabled seandoid in permissive mode, we are observing some of the permissions are getting denied. We are witnessing few processes are getting killed because of lack of permission.
> Is there any new changes which is causing this issues?
> Thanks,Avijit 		 	   		  

SE for Android-specific questions should go to seandroid-list after
subscribing (send mail to seandroid-list-join@tycho.nsa.gov and follow
the instructions in the confirmation email).  See
http://seandroid.bitbucket.org for information about SE for Android.

You didn't say how you were trying to set the context of a symlink, or
what error you were getting if any.

You didn't indicate what version you are using.

You didn't show the particular denials.
