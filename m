Message-ID: <40A464EB.5030008@snu.edu>
Date: Fri, 14 May 2004 01:19:23 -0500
From: Joshua Brindle <jbrindle@snu.edu>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: X policy classes
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We noticed today that the SE-X policy classes have been merged into the 
sf.net cvs policy. Is there an ETA on when those will be merged into the 
kernel headers?

The reason I ask is because we added the pax class in Gentoo policy and 
kernels, now the ordering becomes an issue because with our current 
kernels (with pax support included) the policy flask/access_vectors 
ordering would have to have pax and then X classes but that would 
prevent a user from using a vanilla kernel which has the X classes in 
the headers.

We'll probably go ahead and add the X classes to our kernel headers and 
pax below them so that both vanilla and gentoo kernels would be able to 
load the same policy but we'll need to make changes to our policy and 
would like to know when we can expect the headers to be changed.

Another idea might be to add the pax class to the standard access_vector 
  file but I'm not sure how receptive that would be since afaik we are 
the only ones using it.

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
