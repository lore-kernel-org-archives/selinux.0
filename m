Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAKMo8vb015054
 for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2017 17:50:08 -0500
Received: by mail-lf0-f42.google.com with SMTP id x68so11568967lff.0
 for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2017 12:25:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114101053.29533-1-martink@posteo.de>
References: <20171114101053.29533-1-martink@posteo.de>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Nov 2017 15:25:15 -0500
Message-ID: <CAHC9VhSVX0xYjEGAnuWYpZER=gvnjSuPn4-w9p2Cb5OOXQ5Rhw@mail.gmail.com>
To: Martin Kepplinger <martink@posteo.de>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>, serge@hallyn.com,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] security: replace FSF address with web source
 in license notices
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 14, 2017 at 5:10 AM, Martin Kepplinger <martink@posteo.de> wrote:
> A few years ago the FSF moved and "59 Temple Place" is wrong. Having this
> still in our source files feels old and unmaintained.
>
> Let's take the license statement serious and not confuse users.
>
> As https://www.gnu.org/licenses/gpl-howto.html suggests, we replace the
> postal address with "<http://www.gnu.org/licenses/>" in the security
> directory.
>
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> ---
>  security/selinux/include/netlabel.h | 3 +--
>  security/selinux/netlabel.c         | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

[NOTE: added the SELinux list to the CC line]

Looks fine to me, I'll add it to the SELinux queue for after the merge
window closes.

> diff --git a/security/selinux/include/netlabel.h b/security/selinux/include/netlabel.h
> index 75686d53df07..e77a5e307955 100644
> --- a/security/selinux/include/netlabel.h
> +++ b/security/selinux/include/netlabel.h
> @@ -19,8 +19,7 @@
>   * the GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   *
>   */
>
> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index aaba6677ee2e..2c297b995b16 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -22,8 +22,7 @@
>   * the GNU General Public License for more details.
>   *
>   * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   *
>   */
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
