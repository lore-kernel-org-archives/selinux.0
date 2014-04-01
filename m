Message-ID: <533AD77B.3070107@tycho.nsa.gov>
Date: Tue, 01 Apr 2014 11:12:59 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
 in a confined domain
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
In-Reply-To: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/01/2014 09:59 AM, Kim Lawson-Jenkins wrote:
> Hi,
> 
>  
> 
> I’m pretty sure my questions are basic SELinux 101 but I’m having a
> problem confining an application when a user runs the application
> directly.  On our system I have removed the unconfined domain and
> unconfined user.  When the system initializes the confined applications
> run in the correct confined domains.  However, if I use ssh to access
> the server, stop an application, and then start the application again,
> the application will run with the label sshd_t.  I haven’t tried
> starting a confined application from a local console but I’ll probably
> encounter a similar problem.  How should I modify the policy to allow a
> confined user to execute an application but  also have the application
> run in the application’s confined domain?

If it is running in sshd_t, that suggests a bug in your policy that
prevented sshd from transitioning into a user domain.

When you removed the unconfined domain and user, did you also update
your semanage login and semanage user mappings so that no user is still
being mapped to unconfined_u / unconfined_r?
