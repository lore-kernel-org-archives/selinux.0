Message-ID: <4BF41DD1.1070608@tycho.nsa.gov>
Date: Wed, 19 May 2010 13:20:17 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>, refpolicy@oss1.tresys.com
Subject: Re: Howto enable or disable clipboard with selinux?
References: <AANLkTinfrhS8r4gnc92Pmt78dQ080wlJEdH8qZjM0ZjK@mail.gmail.com> <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
In-Reply-To: <AANLkTimOdxgxn1jBFfWABOvTQbOK9ZT6sMsjFCdZQp2L@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 05/19/2010 11:33 AM, Shaz wrote:
> On Sat, May 15, 2010 at 10:50 PM, Shaz <shazalive@gmail.com> wrote:
>   
>> Dear list,
>>
>> I want to enable or disable the clipboard with booleans. Is there any
>> available policy that can do this? If not please indicate the relevant place
>> to start with.
>>     
> There was a flaw in this question that someone on selinux irc
> explained to me. We need to control an application's access to
> booleans. But I am still not sure how much and what effort it
> requires? Pointer to tutorials or some guidance will be appreciated.
>
> Which version of XACE can do this going as back and earlier as possible?
>
>
>   


You could deny access to the clipboard by labeling the PRIMARY,
SECONDARY, and CLIPBOARD selections (in the x_contexts file) with a
context that application domains don't have permissions to access.  But
this will result in BadAccess X protocol errors being returned to the
application, which will probably abort() as a result (the standard Xlib
error handling method is to call abort).

You could also polyinstantiate X selections, which would cause the
clipboard to stop working unless the two parties (selection owner and
ConvertSelection request issuer) have the exact same context.  But if
you do this, be aware that there are other selections (besides the
clipboard ones) that you will need to keep as single instances if you
want things like D-Bus to work.  Finding and dealing with all of these
is a topic of interest at the moment.

An x_contexts file with the following "selections" section would
implement the second option (the file is located in the contexts/
directory of the SELinux policy configuration):

#
##
### Rules for X Selections
##
#

# Put all your single-instance exceptions here
selection @server=ibus			system_u:object_r:xselection_t:s0
selection _DBUS_*			system_u:object_r:xselection_t:s0

# Default fallback type, will polyinstantiate everything else
poly_selection *			system_u:object_r:xselection_t:s0






-- 

Eamon Walsh 
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
